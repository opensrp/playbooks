# Inventories

Copy over your inventory files here. We recommend you track them in a seperate private git repository. Please do not make pull requests to this repository with inventory files that might expose aspects of your infrastructure that you don't want exposed.

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
│── dynamic-inventory-scripts
│   └── ...
│── [DevOps Client 1]
│   │── [Environment 1]
│   │   │── ec2.py -> ../../dynamic-inventory-scripts/aws/ec2.py
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

The [dynamic inventory](http://docs.ansible.com/ansible/latest/intro_dynamic_inventory.html) scripts (like `ec2.py`) in the environment directories are actually symbolic links to the files kept in [./dynamic-inventory-scripts](./dynamic-inventory-scripts). It's OK to copy over the script with its config file ([ec2.ini](./dynamic-inventory-script/aws/ec2.ini) for instance), only if you're unable to use the default config file. Please note that you should only include a dynamic inventory script in environment directories that use it.
