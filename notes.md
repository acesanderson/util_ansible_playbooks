## Purpose of this directory
- I will be using Ansible to manage config across my computers
- this is all the hosts defined in my ~/.ssh/config file
- Otis is my test case for this
- In parallel, I will have similar settings in dockerfiles for my servers / spinup envs

## General notes about ansible
- you define hosts in an .ini file (which you can save at /etc/ansible/hosts -- which I've done)
- you define tasks in playbooks

```bash
ansible-playbook -i inventory.ini playbook.yml
ansible-playbook -i inventory.ini playbook.yml --ask-become-pass # for sudo
ansible-playbook -i inventory.ini playbook.yml -vvv # for debugging
ansible-playbook -i inventory.ini playbook.yml --check # for dry run
ansible-playbook -i inventory.ini playbook.yml --list-hosts # for listing hosts

# Now that we have /etc/ansible/hosts defined
ansible-playbook playbook.yml
```

## Things I can do
- install my preferred python3.12.4
- git pulls so my apps are up to date
- dotfiles -- have Caruana dotfiles be the template for any ubuntu machine, for example
 - templatize these using jinja2, so you can customize for hostname
- nvim configs
- tmux configs
- apt
- pip
- ssh

## Hosts to do this with
- Otis (Raspbian)
- Larsen (Linux Mint)
- Gotham (PopOS)
- fleet of docker containers with chess player names

## Fleet -- 23 containers
Anand
Nimzowitsch
Tal
Spassky
Euwe
Lasker
Gelfand
Kramnik
Aronian
Ivanchuk
Short
Morozevich
Grischuk
Nepomniachtchi
Shirov
Harikrishna
Ding
Svidler
Radjabov
Nisipeanu
Vachier-Lagrave
Kamsky
Gulko

