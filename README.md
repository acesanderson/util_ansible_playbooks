# Ansible System Playbooks

A collection of Ansible playbooks and inventory configurations for automated provisioning and management of Linux systems across Mariner, Jetson, and Ubuntu environments.

## Quick Start

Execute a local test using Docker to verify playbook logic before deployment.

### 1. Start Test Environment
```sh
docker run -d --name mariner-test -p 2222:22 mariner-test
```

### 2. Run Playbook
```sh
ansible-playbook -i inventory/local.ini playbook.yml
```

### 3. Verify Changes
```sh
docker exec -it mariner-test bash
```

## Environment Management

The project uses environment-specific inventory files to manage different hardware and OS targets. Each inventory specifies the required Python interpreter and connection parameters.

| Environment | Inventory File | Target Host | System Type |
|-----------|---------------|-------------|-------------|
| Local Test | `inventory/local.ini` | localhost:2222 | Docker / Mariner |
| Production | `inventory/prod.ini` | dev | Mariner |
| NVIDIA Jetson | `inventory/jetson.ini` | cheet-ip | Jetson (Python 3.9) |
| Ubuntu | `inventory/nimzo.ini` | nimzo | Ubuntu |

## Usage

### Production Deployment
To apply configurations to production targets, specify the production inventory:

```sh
ansible-playbook -i inventory/prod.ini playbook.yml
```

### Specific Target Execution
To target specific hardware like the Jetson module:

```sh
ansible-playbook -i inventory/jetson.ini playbook.yml
```

## Requirements

- **Ansible 2.9+**: Installed on the control node.
- **SSH Access**: Key-based authentication configured for target hosts.
- **Docker**: Required only for local testing workflows.
- **Python 3**: Installed on all target nodes (managed automatically via `ansible_python_interpreter` in inventories).

## Configuration Details

The inventory files define specific connection string requirements:

- **Mariner (Local)**: Configured to bypass strict host key checking for volatile Docker containers.
- **Python Overrides**: Systems like the Jetson module utilize specific paths (`/usr/bin/python3.9`) to ensure compatibility with system-level libraries.
- **SSH Ports**: Local testing redirects to port 2222 to avoid conflicts with host SSH services.
