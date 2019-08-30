## Example Inventory

This is an example inventory that will deploy OpenSRP Server and OpenMRS in a single host (called `host1` in the files). Here's the host's [variable file](./host_vars/host1/vars.yml) (containing the `ansible_ssh_user` and `ansible_ssh_host` variables).

### Considerations

1. In this inventory, secrets haven't been placed in [Ansible Vault](https://docs.ansible.com/ansible/latest/user_guide/vault.html) files. You should, however, consider putting yours in vaulted files.
1. The inventory assumes that you will not be running the setup-server.yml playbook.
1. Database backups have been disabled for Redis, MySQL, and PostgreSQl. Consider enabling them.