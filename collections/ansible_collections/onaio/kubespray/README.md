# Ansible Collection - onaio.kubespray

## Overview

This documentation outlines the steps to be taken to bring up an on premise cluster using kubespray. The official documentation is [here](https://kubespray.io/#/). The following instructions will setup a cluster with; nfs volumes (dynamic provisioning), metallb load balancer (layer 2), ingress nginx, acme cluster issuer, containerd as CRI and calico as network plugin.

## Requirements

In addition to the [official kubespray requirements](https://github.com/kubernetes-sigs/kubespray#requirements) and [supported linux distributions](https://github.com/kubernetes-sigs/kubespray#supported-linux-distributions), add one VM to be used outside the cluster as an NFS server.

## Environment Setup and Preparation

Clone this repository with its Git submodules:

```sh
git clone --recursive git@github.com:opensrp/playbooks.git && cd playbooks
```

### Install the dependencies for ansible to run the kubespray playbook

Install dependencies from `requirements.txt`

```shell
pip3 install -r collections/ansible_collections/onaio/kubespray/external/kubespray/requirements.txt
pip3 install -r requirements/kubernetes.pip
```

### Install ansible collections and roles

Install the [Ansible Galaxy](https://docs.ansible.com/ansible/latest/reference\_appendices/galaxy.html) requirements using these commands:

```sh
ansible-galaxy role install -r requirements/ansible-galaxy.yml -p ~/.ansible/roles/opensrp
ansible-galaxy collection install -r requirements/ansible-galaxy.yml -p ~/.ansible/collections/opensrp
```

### Copy `collections/ansible_collections/onaio/kubespray/external/kubespray/inventory/sample/` as `inventories/<project>/kubernetes/<cluster-name>`

```shell
mkdir -p inventories/<project>/kubernetes/<cluster-name> && cp -rfp collections/ansible_collections/onaio/kubespray/external/kubespray/inventory/sample/* inventories/<project>/kubernetes/<cluster-name>
```

### Update Ansible inventory file with inventory builder

```shell
declare -a IPS=(10.10.1.3 10.10.1.4 10.10.1.5)
CONFIG_FILE=inventories/<project>/kubernetes/<cluster-name>/hosts.yaml python3 collections/ansible_collections/onaio/kubespray/external/kubespray/contrib/inventory_builder/inventory.py ${IPS[@]}
```

### Review and change parameters under `inventories/<project>/kubernetes/<cluster-name>/group_vars`

```shell
cat inventories/<project>/kubernetes/<cluster-name>/group_vars/all/all.yml
cat inventories/<project>/kubernetes/<cluster-name>/group_vars/k8s_cluster/k8s-cluster.yml
```

### Modify default kubespray configurations

Open the generated `inventories/<project>/kubernetes/<cluster-name>/hosts.yaml` file and adjust nodes setup i.e choosing which nodes are masters and worker nodes. Also update the `ip` to the respective private ip and comment out the `access_ip`.

```yaml
 node1:
    ansible_host: #the public ip
    ip: #the private ip
    #access_ip: commented out
  node2:
```

The main configuration for the cluster is stored in `inventories/<project>/kubernetes/<cluster-name>/group_vars/k8s_cluster/k8s-cluster.yml`. In this file we will update the `supplementary_addresses_in_ssl_keys` with a list of the IP addresses or domain of the controller nodes. In that way we can access the kubernetes API server as an administrator from outside the private network.
i.e

```yaml
supplementary_addresses_in_ssl_keys: []
```

You can also see that the `kube_network_plugin` is by default set to 'calico'.

## Deploying the cluster

To deploy Kubespray with Ansible Playbook - run the playbook as root. The option `--become` is required, as for example writing SSL keys in /etc/, installing packages and interacting with various systemd daemons, without --become the playbook will fail to run!

```shell
ansible-playbook -i inventories/<project>/kubernetes/<cluster-name> --become --become-user=root kubernetes.yml -t cluster --extra-vars "ansible_ssh_user=ubuntu"  -e "reset_confirmation=no"
```

Ansible will now execute the playbook, this can take up to 20 minutes.

## Actions after cluster setup using kubespray collection

The cluster uses metallb (layer2 type) as the load balancer, to make the cluster accessible to the public one has to run the following play `kubernetes.yml` with tag `post-cluster-setup` but before that we need to know the following:

*   The interface used by kubernetes network. (use `ifconfig`)
*   The external ip of ingress controller service.

```shell
kubectl -n ingress-nginx get svc ingress-nginx-controller -o jsonpath='{.status.loadBalancer.ingress[].ip}'
```

### Update the following values in all.yml of your inventory accordingly

```yaml
# external ip for ingress nginx controller with port it maps to usually 80/443
# any another service to be accessed external on a custom port can be added here, provided it has an LoadBalancer service type.
port_ip_map:
  - 192.168.100.2:80
  - 192.168.100.2:443

# default tunl0, if its same as the default one can omit the below variable.
kubespray_k8s_interface: tunl0
```

### Run the k8s post cluster setup play

This will setup the following:

*   nfs servers & clients
*   cert-manager & cluster issuer
*   nfs provisioner
*   ingress nginx controller with service type load balancer
*   additional iptables to make cluster accessible publicly using layer2 metallb. (check the above 2 steps)

```shell
ansible-playbook -i inventories/<project>/kubernetes/<cluster-name> kubernetes.yml -t post-cluster-setup --extra-vars "ansible_ssh_user=ubuntu"  -e "reset_confirmation=no"
```

At this point you can start installing the applications to the cluster.
