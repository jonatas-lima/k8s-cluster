#!/bin/bash

KUBESPRAY_PATH="./kubespray"

function get_public_ip() {
  vm=$1
  vagrant ssh "$vm" -c 'hostname -I | cut -d " " -f2' | sed 's/\r$//'
}

control_plane_ip="$(get_public_ip "control-plane-1")"
data_plane_1_ip="$(get_public_ip "data-plane-1")"
data_plane_2_ip="$(get_public_ip "data-plane-2")"

cluster_uuid="$KUBESPRAY_PATH/inventory/vagrant"

cp -rfp "$KUBESPRAY_PATH/inventory/sample" "$cluster_uuid"

cat <<EOF > "$cluster_uuid/inventory.ini"
[all]
control-plane-1 ansible_host=$control_plane_ip ip=$control_plane_ip etcd_member_name=etcd1
data-plane-1 ansible_host=$data_plane_1_ip ip=$data_plane_1_ip
data-plane-2 ansible_host=$data_plane_2_ip ip=$data_plane_2_ip

[all:vars]
ansible_user=vagrant
ansible_ssh_common_args='-o StrictHostKeyChecking=no'

[kube_control_plane]
control-plane-1

[etcd]
control-plane-1

[kube_node]
data-plane-1
data-plane-2

[calico_rr]

[k8s_cluster:children]
kube_control_plane
kube_node
calico_rr
EOF
