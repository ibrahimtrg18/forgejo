#!/bin/bash

# deploy.sh - Deploy Forgejo stack to Kubernetes

set -euo pipefail
# set -e → exit on first error
# set -u → error if undefined variable
# set -o pipefail → fail if any command in a pipeline fails

# Load environment variables from ../.env
if [ -f ../.env ]; then
  source ../.env
else
  echo "Error: .env file not found"
  exit 1
fi

NAMESPACE=forgejo

# Create secrets
kubectl create secret generic postgres-secret -n $NAMESPACE \
  --from-literal=POSTGRES_USER="$POSTGRES_USER" \
  --from-literal=POSTGRES_PASSWORD="$POSTGRES_PASSWORD" \
  --from-literal=POSTGRES_DB="$POSTGRES_DB" --dry-run=client -o yaml | kubectl apply -f -

kubectl create secret generic forgejo-secret -n $NAMESPACE \
  --from-literal=FORGEJO_ADMIN_PASSWORD="$FORGEJO_ADMIN_PASSWORD" \
  --from-literal=FORGEJO_SECRET_KEY="$FORGEJO_SECRET_KEY" --dry-run=client -o yaml | kubectl apply -f -

MANIFEST_DIR="./manifest"

# Optional: check if kubectl exists
if ! command -v kubectl &> /dev/null; then
    echo "Error: kubectl not found. Please install kubectl first."
    exit 1
fi

echo "=== Starting Forgejo deployment ==="

# 1️⃣ Namespace
echo "-> Creating namespace..."
kubectl apply -f "$MANIFEST_DIR/00-namespace.yml"

# 2️⃣ Secrets
echo "-> Applying secrets..."
kubectl apply -f "$MANIFEST_DIR/01-secret.yml"

# 3️⃣ Postgres
echo "-> Deploying Postgres..."
kubectl apply -f "$MANIFEST_DIR/02-postgres.yml"

# 4️⃣ Forgejo
echo "-> Deploying Forgejo..."
kubectl apply -f "$MANIFEST_DIR/03-forgejo.yml"

# 5️⃣ Ingress
echo "-> Deploying Ingress..."
kubectl apply -f "$MANIFEST_DIR/04-ingress.yml"

echo "=== Deployment complete! ==="
echo "You can check pods with: kubectl get pods -n forgejo"
