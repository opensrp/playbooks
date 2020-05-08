# Ansible Playbooks [![Build Status](https://travis-ci.com/OpenSRP/playbooks.svg?branch=master)](https://travis-ci.com/OpenSRP/playbooks)

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
git clone --recursive git@github.com:opensrp/playbooks.git && cd playbooks
```

Make sure all [pip][5] requirements are installed by running the following command. We recommend
you do this in a dedicated [Python virtual env][6]:

```sh
pip install -r requirements/base.pip
```

Install the [Ansible Galaxy](https://docs.ansible.com/ansible/latest/reference_appendices/galaxy.html) requirements using these commands:

```sh
mkdir -p ~/.ansible/roles/opensrp
ansible-galaxy install -r requirements/ansible-galaxy.yml -p ~/.ansible/roles/opensrp
```

### Note on Mitogen

We use [Mitogen][8] as the connection backend for Ansible because it is worlds faster than the default Ansible connection backend. This, however, means that we have to install some pip requirements and point Ansible (using the strategy_plugins configuration) to a directory installed by the mitogen pip package. This, therefore, means that the location of this directory is going to be different depending on what your Python virtualenv (if you're using one) is called and what Python version you use. The path to this directory in ansible.cfg is what is in the admin host, since that is where we recommend Ansible to be ran from.

If the Ansible strategy plugin is located in a location other than ~/.virtualenvs/opensrp/lib/python3.6/site-packages/ansible_mitogen/plugins/strategy, override the default Ansible strategy plugin path by exporting ANSIBLE_STRATEGY_PLUGINS.

```sh
export ANSIBLE_STRATEGY_PLUGINS=<virtualenv_root>/lib/<python_version>/site-packages/ansible_mitogen/plugins/strategy
```

## Inventories

Copy over your inventory files into a new directory called `inventories`. Note that we have `inventories` in the .gitignore file. We recommend you track them in a seperate private git repository. Please do not make pull requests to this repository with inventory files that might expose aspects of your infrastructure that you don't want exposed.

We recommend you use the following directory structure:

Split your inventories based on DevOps clients, and their server environments.

Example DevOps clients include:

 - personal (for your personal inventories)
 - tb-reach
 - zeir

And environments:

 - production
 - preview
 - staging

The inventory directory structure, hence, looks like:

```
inventories/
│── [DevOps Client 1]
│   │── [Environment 1]
│   │   │── group_vars
│   │   │── hosts
│   │   └── host_vars
│   .
│   .
│   .
│   └── [Environment m]
│       └ ...
.
.
.
└── [DevOps Client n]
    └ ...
```

Each environment directory contains a `hosts` file that's used to group `host_vars` into `group_vars` and `group_vars` into other `group_vars`. Please avoid setting ansible variables in that file.

## Packer

[Packer][7] allows for packaging of machine/container images from Ansible scripts like the ones defined in this repository. To run any of the packer files defined in this repository, do:

```sh
packer build -var-file=inventories/<DevOps client>/<environment>/packer/<name of setup>/<name of variant>.json packer/<name of setup>.json
```

[1]: https://www.ansible.com
[2]: https://pypi.python.org/pypi/pycrypto
[3]: https://www.virtualbox.org
[4]: https://docs.ansible.com/ansible/playbooks_best_practices.html#alternative-directory-layout
[5]: https://pip.pypa.io/en/stable/
[6]: https://virtualenvwrapper.readthedocs.io/en/latest/
[7]: https://packer.io/
[8]: https://mitogen.networkgenomics.com/ansible_detailed.html
