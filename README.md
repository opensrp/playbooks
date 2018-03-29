# Ansible Playbooks [![Build Status](https://travis-ci.org/OpenSRP/playbooks.svg?branch=master)](https://travis-ci.org/OpenSRP/playbooks)

A collection of [Ansible][1] scripts and templates used to deploy systems used by OpenSRP.
We use Ansible's recommended [alternative directory layout][4].

## Setup

To run the stuff herein, you need Ansible. To use [Ansible][1] you might need [pycrypto][2].
To build pycrypto, you need the latest python (2.1 <= ver <= 3.3) development libs & headers.
Stick with python v2.7 for now. It's the current status quo.
In a nutshell, if you're using debian/ubuntu :- `apt-get install python-dev`

For local "dev" deployments, you will need to install [Virtualbox][3]. You'll need the password
used to encrypt sensitive info in this repo.

Clone this repository with its Git submodules:

```sh
git clone --recursive git@github.com:onaio/playbooks-opensrp.git && cd playbooks-opensrp
```

Make sure all [pip][5] requirements are installed by running the following command. We recommend
you do this in a dedicated [Python virtual env][6]:

```sh
pip install -r requirements.txt
```

## Deploying from Ona's DevOps Host

YOu can run these plays from Ona's DevOps host, if you have access to it. SSH in as the `devops`
user then run:

```sh
workon playbooks
cd ~/opensrp-playbooks
```

## Temporary Personal Inventory

Create a local inventory, that won't be shared with others on Git, by adding the inventory and vars
files in [inventories/personal](./inventories/personal).

[1]: https://www.ansible.com
[2]: https://pypi.python.org/pypi/pycrypto
[3]: https://www.virtualbox.org
[4]: https://docs.ansible.com/ansible/playbooks_best_practices.html#alternative-directory-layout
[5]: https://pip.pypa.io/en/stable/
[6]: https://virtualenvwrapper.readthedocs.io/en/latest/
