#!/bin/bash

# Run playbook for each host with its specific vault-stored password
for host in Larsen Gotham Cheet; do
    ansible-playbook dev.yaml -i inventory.ini --limit $host -b --vault-id $host@prompt
done
