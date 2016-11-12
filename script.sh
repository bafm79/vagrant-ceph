#!/bin/bash

# pre-req: (Already satisfied if using Vagrantfile)
# - Configured networks
# - pub key into vms 
# - repo http://download.ceph.com/rpm-jewel/el7/noarch/ceph-release-1-0.el7.noarch.rpm installed

fsid=$(uuidgen)

git clone https://github.com/ceph/ceph-ansible.git

echo '
[mons]
192.168.0.101
192.168.0.102
192.168.0.103

[osds]
192.168.0.111
192.168.0.112
192.168.0.113

#[mdss]


#[rgws]
#192.168.0.101

' > hosts.ceph

ansible all -m ping -u root  -i hosts.ceph

cp ceph-ansible/site.yml.sample ceph-ansible/site.yml
cp ceph-ansible/group_vars/all.sample ceph-ansible/group_vars/all
cp ceph-ansible/group_vars/mons.sample ceph-ansible/group_vars/mons
cp ceph-ansible/group_vars/osds.sample ceph-ansible/group_vars/osds
cp ceph-ansible/group_vars/rgws.sample ceph-ansible/group_vars/rgws

echo ' 
fetch_directory: fetch/
cluster: ceph 
ntp_service_enabled: False
ceph_origin: "distro"
#ceph_origin: "upstream"
ceph_stable: true 
fsid: '${fsid}'
generate_fsid: false 
cephx: true
monitor_interface: enp0s8
public_network: 192.168.0.0/24 
cluster_network: 7.7.7.0/24
osd_mkfs_type: xfs
journal_size: 5120

#radosgw_frontend: civetweb 
#radosgw_civetweb_port: 443 
#radosgw_civetweb_bind_ip: 0.0.0.0
#radosgw_civetweb_num_threads: 50
#radosgw_keystone: true
#radosgw_keystone_url: http://10.200.187.7:35357
#radosgw_keystone_admin_token: password
#radosgw_keystone_accepted_roles: Member, _member_, admin
#radosgw_keystone_token_cache_size: 10000
#radosgw_keystone_revocation_internal: 900
#radosgw_s3_auth_use_keystone: "true"
#radosgw_nss_db_path: /var/lib/ceph/radosgw/ceph-radosgw.{{ ansible_hostname }}/nss

' >> ceph-ansible/group_vars/all


echo '
monitor_secret: "{{ monitor_keyring.stdout }}"
cephx: true
' >> ceph-ansible/group_vars/mons


echo '
osd_auto_discovery: true
journal_collocation: true
' >> ceph-ansible/group_vars/osds


echo '
# ??

' >> ceph-ansible/group_vars/rgws


