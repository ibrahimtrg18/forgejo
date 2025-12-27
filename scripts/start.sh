#!/bin/bash

# start.sh - Start Forgejo stack in Kubernetes

set -euo pipefail

NAMESPACE=forgejo

echo "=== Starting Forgejo stack in namespace: $NAMESPACE ==="

# Scale deployments back to 1 replica
kubectl scale deployment --all --replicas=1 -n $NAMESPACE

echo "=== Forgejo stack started! Check pods with: kubectl get pods -n $NAMESPACE ==="
