# GoCD

Files herein relate to using the deployment scripts in this repository within GoCD. [GoCD](https://www.gocd.org/) is an open source continuous delivery pipeline tool.

## Directory Structure

Here's the proposed directory structure for the .gocd directory

```shell
.gocd/
├── pipelines
│   └── opensrp-web
│       ├── cloud-blue_green.yml
│       └── cloud-simple.yml
└── scripts
    ├── ansible.sh
    ├── packer.sh
    └── terraform.sh
```

The `scripts` directory contains scripts that need to be run from within pipelines.

The `pipelines` directory contains GoCD pipelines that have been exported into files. See GoCD's documentation on [pipelines as code](https://docs.gocd.org/current/advanced_usage/pipelines_as_code.html).
