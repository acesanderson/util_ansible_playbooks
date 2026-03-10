# myvm Ansible Provisioning

Provisions `bianders-ld1.linkedin.biz` (CBL-Mariner 2.0, Azure-hosted) into a functional dev environment.

## What it installs

- tmux + config + tpm + tmux-sensible
- neovim + full config (via tdnf; lazy.nvim bootstraps on first launch)
- uv
- bash dotfiles: `.bash_profile`, `.bashrc`, `.aliases`, `.exports`, `.functions`
- git config
- tmux auto-attach (attaches to session `main` on login)

## Prerequisites (controller — this Mac)

```sh
uv tool install ansible
brew install hudochenkov/sshpass/sshpass   # needed for local password auth test
```

## Local test (Docker)

```sh
# 1. Build the Mariner test image
docker build -t mariner-test .

# 2. Run it with SSH on port 2222
docker run -d --name mariner-test -p 2222:22 mariner-test

# 3. Run the playbook against it
ansible-playbook -i inventory/local.ini playbook.yml

# 4. SSH in and verify
ssh -p 2222 -o StrictHostKeyChecking=no bianders@localhost

# 5. Tear down
docker rm -f mariner-test
```

## Production

```sh
ansible-playbook -i inventory/prod.ini playbook.yml
```

Assumes SSH access to `bianders-ld1.linkedin.biz` is already working (LinkedIn corp SSO / SSH certificate).

## Open questions (resolve before prod run)

- Is tdnf's neovim >= 0.8? (lazy.nvim requires it — the playbook prints the version)
- Does the VM have outbound internet? (needed for: uv install script, lazy.nvim plugin bootstrap)
- Personal SSH key policy on corp VMs
- Rootless podman: does it work without extra config on Mariner?
- Policy on running persistent services (FastAPI, vector DB) on myvm VMs?

## Structure

```
Ansible/
  Dockerfile              # CBL-Mariner 2.0 + sshd for local testing
  playbook.yml            # Main idempotent playbook
  inventory/
    local.ini             # Docker container (port 2222)
    prod.ini              # bianders-ld1.linkedin.biz
  files/
    bash/                 # Dotfiles subset (VM-adapted)
      .bash_profile
      .bashrc             # Stripped: no direnv hook guard removed, no siphon completion
      .aliases
      .exports            # Stripped: no macOS paths (ONEDRIVE, CLAUDE_PATH, etc.)
      .functions
    tmux/
      tmux.conf           # VM variant: no everforest/battery (require internet); tpm + sensible only
    git/
      .gitconfig
      .gitignore_global
```

Note: nvim config is copied directly from `~/.dotfiles/nvim/` on the controller at playbook runtime. The `require("python")` line in `init.lua` is disabled via `lineinfile` post-copy.
