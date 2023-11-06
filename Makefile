SHELL := /bin/bash

cluster:
	vagrant up && bash create_hosts.sh && cd kubespray && ansible-playbook -b -v -i inventory/vagrant/inventory.ini cluster.yml

reset:
	cd kubespray && ansible-playbook -i inventory/vagrant/inventory.ini -b -v reset.yml

destroy:
	vagrant destroy -f && rm -rf kubespray/inventory/vagrant
