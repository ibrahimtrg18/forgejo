#!/bin/bash

# remove.sh - Completely remove Forgejo stack from Kubernetes

set -euo pipefail

NAMESPACE=forgejo

echo "=== Removing Forgejo stack in namespace: $NAMESPACE ==="

# 1️⃣ Delete Deployments
echo "-> Deleting deployments..."
kubectl delete deployment --all -n $NAMESPACE

# 2️⃣ Delete Services
echo "-> Deleting services..."
kubectl delete service --all -n $NAMESPACE

# 3️⃣ Delete Ingress
echo "-> Deleting ingress..."
kubectl delete ingress --all -n $NAMESPACE

# 4️⃣ Delete Secrets
echo "-> Deleting secrets..."
kubectl delete secret --all -n $NAMESPACE

# 5️⃣ Delete PVCs (persistent storage)
echo "-> Deleting PersistentVolumeClaims..."
kubectl delete pvc --all -n $NAMESPACE

# 6️⃣ Delete the namespace itself
read -p "Do you want to delete the namespace '$NAMESPACE' as well? [y/N]: " yn
if [[ "$yn" =~ ^[Yy]$ ]]; then
    echo "-> Deleting namespace..."
    kubectl delete namespace $NAMESPACE
else
    echo "-> Namespace left intact."
fi

echo "=== Forgejo stack removed! ==="
