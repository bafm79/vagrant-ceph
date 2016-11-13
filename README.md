# vagrant-ceph

This repo contains:

- a Vagrantfile for creating some centos7.2 vms on virtualbox
- a script.sh file for preparing the env for ceph-ansible deploy

run: ansible-playbook site.yml -u root -f 6 -i ../hosts.ceph

