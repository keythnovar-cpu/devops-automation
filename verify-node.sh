#!/bin/bash

echo "---- Verifying Kubernetes Node Setup ----"

echo ""
echo "1. Checking Swap..."
if swapon --show | grep -q swap; then
  echo "❌ Swap is ENABLED"
else
  echo "✅ Swap is disabled"
fi

echo ""
echo "2. Checking Kernel Modules..."

if lsmod | grep -q overlay; then
  echo "✅ overlay module loaded"
else
  echo "❌ overlay module NOT loaded"
fi

if lsmod | grep -q br_netfilter; then
  echo "✅ br_netfilter module loaded"
else
  echo "❌ br_netfilter module NOT loaded"
fi

echo ""
echo "3. Checking sysctl Settings..."

IPF=$(cat /proc/sys/net/ipv4/ip_forward)
if [ "$IPF" = "1" ]; then
  echo "✅ IP forwarding enabled"
else
  echo "❌ IP forwarding disabled"
fi

BR1=$(cat /proc/sys/net/bridge/bridge-nf-call-iptables)
if [ "$BR1" = "1" ]; then
  echo "✅ bridge-nf-call-iptables enabled"
else
  echo "❌ bridge-nf-call-iptables disabled"
fi

echo ""
echo "4. Checking containerd..."

if systemctl is-active --quiet containerd; then
  echo "✅ containerd is running"
else
  echo "❌ containerd is NOT running"
fi

echo ""
echo "5. Checking Static Host-Only IP..."

ip addr show enp0s8 | grep inet

echo ""
echo "---- Verification Complete ----"
