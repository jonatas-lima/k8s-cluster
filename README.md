# K8S Cluster

This repository creates (currently) a 3-node [Kubernetes](https://kubernetes.io/) on-premise cluster, 1 control plane and 2 data planes.

## Motivation

Instead of using learning tools such as Kind and Minikube, we can use a on-premise K8S cluster using virtual machines on your own host machine.

Why? **Doing this way is more fun and more similar to how it is done in on-premises environments**.

Of course this way it's more complicated, but it will be worth it.

## Before we start

### Pre requisites

* [ansible](https://www.ansible.com/)
* [vagrant](https://www.vagrantup.com/)
* [virtualbox](https://www.virtualbox.org/wiki/Downloads)
* make
* at least 8GB RAM

### Ansible

```sh
python3 -m pip install --user ansible
```

### Vagrant

#### Ubuntu based

```sh
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install vagrant -y
```

#### Fedora

```sh
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
sudo dnf -y install vagrant
```

#### CentOS/RHEL

```sh
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install vagrant
```

## Managing your cluster

The created cluster will use 6GB of RAM, so it's very likely that your machine will slow down a little.

### Creating

```sh
make cluster
```

### Interacting

Just log into the control plane and start playing with Kubernetes.

```sh
vagrant ssh control-plane-1
```

```sh
kubectl get node
k get pods -A # it will be created an alias 'k' to kubectl
# ...
```

### Destroying

```sh
make destroy
```

## Other use case

You can just run the playbook that creates a K8S cluster, just populate correctly on hosts.ini

```sh
cd ansible && ansible-playbook -i hosts.ini cluster.yml
```
