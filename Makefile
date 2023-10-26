SHELL := /bin/bash

cluster:
	vagrant up && bash create_hosts.sh && ansible-playbook -i ansible/hosts.ini ansible/cluster.yml

reset:
	ansible-playbook -i ansible/hosts.ini ansible/reset.yml

destroy:
	vagrant destroy -f
