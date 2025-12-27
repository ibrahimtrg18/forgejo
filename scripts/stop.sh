#!/bin/bash

# stop.sh - Stop Forgejo stack in Kubernetes

set -euo pipefail

NAMESPACE=forgejo

echo "=== Stopping Forgejo stack in namespace: $NAMESPACE ==="

# Scale down all deployments
kubectl scale deployment --all --replicas=0 -n $NAMESPACE

echo "=== Forgejo stack stopped! Pods are terminated, namespace intact ==="
