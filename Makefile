SHELL := /bin/bash

cluster:
	. .env && vagrant up && bash create_hosts.sh && ansible-playbook -i hosts.ini playbook.yml

destroy:
	vagrant destroy -f
