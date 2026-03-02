#!/bin/bash

set -e

echo "---- Installing Kubernetes Packages ----"

echo "1. Installing required dependencies..."
apt update
apt install -y apt-transport-https ca-certificates curl gpg

echo "2. Adding Kubernetes repository..."
mkdir -p /etc/apt/keyrings

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | \
gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] \
https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /" | \
tee /etc/apt/sources.list.d/kubernetes.list

echo "3. Updating package list..."
apt update

echo "4. Installing kubelet, kubeadm, kubectl..."
apt install -y kubelet kubeadm kubectl

echo "5. Holding package versions..."
apt-mark hold kubelet kubeadm kubectl

echo ""
echo "---- Installed Versions ----"
kubeadm version
kubectl version --client
echo "-----------------------------"

echo "Kubernetes packages installed successfully."
