#!/bin/bash

function get_public_ip() {
  vm=$1
  vagrant ssh "$vm" -c 'hostname -I | cut -d " " -f2' | sed 's/\r$//'
}

control_plane_ip="$(get_public_ip "control-plane-1")"
data_plane_1_ip="$(get_public_ip "data-plane-1")"
data_plane_2_ip="$(get_public_ip "data-plane-2")"

cat <<EOF > ansible/hosts.ini
[control-plane]
$control_plane_ip ansible_user=vagrant ansible_ssh_common_args='-o StrictHostKeyChecking=no'

[control-plane:vars]
apiserver_advertise_address=$control_plane_ip

[data-plane]
$data_plane_1_ip  ansible_user=vagrant ansible_ssh_common_args='-o StrictHostKeyChecking=no'
$data_plane_2_ip  ansible_user=vagrant ansible_ssh_common_args='-o StrictHostKeyChecking=no'
EOF
