## Requirements
### Pip
Make sure all [pip][5] requirements are installed by running the following command. We recommend
you do this in a dedicated [Python virtual env](https://virtualenvwrapper.readthedocs.io/en/latest/):

```sh
pip install -r requirements/base.pip
```

### Ansible Galaxy
Install the [Ansible Galaxy](https://docs.ansible.com/ansible/latest/reference_appendices/galaxy.html) requirements using these commands:

```sh
mkdir -p ~/.ansible/roles/opensrp
ansible-galaxy install -r requirements/ansible-galaxy.yml -p ~/.ansible/roles/opensrp
```