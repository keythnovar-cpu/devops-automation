#!/bin/bash

set -e

MASTER_IP="192.168.56.101"
POD_CIDR="10.244.0.0/16"

echo "Initializing Kubernetes Control Plane..."

kubeadm init \
  --apiserver-advertise-address=$MASTER_IP \
  --pod-network-cidr=$POD_CIDR

echo ""
echo "Setting up kubectl access..."

mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

echo ""
echo "Installing Flannel CNI..."

kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml

echo ""
echo "Cluster initialized successfully."
echo "Run 'kubeadm token create --print-join-command' to get worker join command."
