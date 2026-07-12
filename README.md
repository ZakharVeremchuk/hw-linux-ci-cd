# Lesson 7 — EKS + ECR + Helm

Django app on AWS EKS, deployed with Helm.

- **`app/`** — Django + Dockerfile (from topic 4/5)
- **Terraform** — VPC, ECR, EKS
- **Helm chart** (`charts/django-app`) — Deployment, Service, ConfigMap, HPA

## 1. Create infrastructure

```bash
terraform init -reconfigure
terraform apply
```

Connect kubectl:

```bash
aws eks --region us-east-1 update-kubeconfig --name eks-cluster-demo
kubectl get nodes
```

## 2. Push Django image to ECR

```bash
cd app

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <YOUR_ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com

docker build -t lesson-5-ecr:latest .
docker tag lesson-5-ecr:latest <YOUR_ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com/lesson-5-ecr:latest
docker push <YOUR_ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com/lesson-5-ecr:latest
```

## 3. Deploy with Helm

```bash
# from repo root
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

helm upgrade --install django-app ./charts/django-app
kubectl get pods,svc,hpa,configmap
```

Open the app: take `EXTERNAL-IP` from `kubectl get svc`.

## Helm chart

| Resource | Role |
|----------|------|
| Deployment | Django image from ECR + ConfigMap via `envFrom` |
| Service | LoadBalancer (public IP) |
| ConfigMap | Env vars from topic 4 |
| HPA | Scale pods 2–6 when CPU > 70% |

Settings: `charts/django-app/values.yaml`
