# Ansible Configuration for Linksaver

### Encrypt environment variables with ansible bault

```bash
ansible-vault encrypt dev/env_vars_dev.yaml
```

### Setup server

```bash
ansible-playbook --inventory dev/inventory_dev.yaml playbooks/linksaver_setup_playbook.yaml -e @dev/env_vars_dev.yaml --ask-vault-pass
```

### Update containers and images

```bash
ansible-playbook --inventory dev/inventory_dev.yaml playbooks/linksaver_update_playbook.yaml -e @dev/env_vars_dev.yaml --ask-vault-pass
```
