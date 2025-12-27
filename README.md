# Forgejo Kubernetes Deployment

This repository contains the Kubernetes manifests and helper scripts to deploy **Forgejo** with PostgreSQL on a Kubernetes cluster (tested on Docker Desktop).

## Table of Contents

- [Prerequisites](#prerequisites)
- [Deployment](#deployment)

## Prerequisites

- Kubernetes cluster (Docker Desktop, Minikube, or any cluster)
- `kubectl` installed and configured
- `bash` for running scripts
- `.env` file containing the following variables:

```env
POSTGRES_USER=<your_db_user>
POSTGRES_PASSWORD=<your_db_password>
POSTGRES_DB=<your_db_name>
FORGEJO_ADMIN_PASSWORD=<your_admin_password>
FORGEJO_SECRET_KEY=<your_secret_key>
```

## Deployment

Deploy Forgejo and PostgreSQL:

```bash
./deploy.sh
```

- Creates the namespace forgejo
- Creates Secrets for PostgreSQL and Forgejo
- Deploys PostgreSQL and Forgejo
- Creates Services and Ingress

Check pods:

```bash
kubectl get pods -n forgejo
```
