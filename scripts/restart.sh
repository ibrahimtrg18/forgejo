#!/bin/bash

# restart.sh - Restart Forgejo stack in Kubernetes

set -euo pipefail

NAMESPACE=forgejo

echo "=== Restarting Forgejo stack in namespace: $NAMESPACE ==="

# Stop
kubectl scale deployment --all --replicas=0 -n $NAMESPACE

# Start
kubectl scale deployment --all --replicas=1 -n $NAMESPACE

echo "=== Forgejo stack restarted! Check pods with: kubectl get pods -n $NAMESPACE ==="
