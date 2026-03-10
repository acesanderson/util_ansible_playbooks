# Usage

## Local test (Docker)

```sh
# Start container
docker run -d --name mariner-test -p 2222:22 mariner-test

# Run playbook
ansible-playbook -i ~/Ansible/inventory/local.ini ~/Ansible/playbook.yml

# Enter container
docker exec -it mariner-test bash
```

## Production

```sh
ansible-playbook -i ~/Ansible/inventory/prod.ini ~/Ansible/playbook.yml
```
