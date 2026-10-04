# Student App GitOps

GitOps repository for deploying the Student FastAPI application to Amazon EKS using Helm and Argo CD.

## Technologies

- Kubernetes
- Helm
- Argo CD
- Amazon EKS
- Amazon ECR
- Prometheus
- Grafana

## Repository Structure

```text
student-app-gitops/
│
├── helm/
│   └── student-app/
│       ├── Chart.yaml
│       ├── values.yaml
│       ├── values-dev.yaml
│       ├── values-prod.yaml
│       │
│       └── templates/
│           ├── _helpers.tpl
│           ├── configmap.yaml
│           ├── deployment.yaml
│           ├── ingress.yaml
│           ├── service.yaml
│           ├── serviceaccount.yaml
│           └── NOTES.txt
│
└── argocd/
    ├── student-app-dev.yaml
    └── student-app-prod.yaml
```

## Environments

### Development

Namespace:

```text
student-app-dev
```

Values:

```text
values-dev.yaml
```

Argo CD synchronization:

```text
Automatic
Self Heal
Prune
```

### Production

Namespace:

```text
student-app-prod
```

Values:

```text
values-prod.yaml
```

Argo CD synchronization:

```text
Manual
```

## Application Endpoints

```text
/
```

Main API.

```text
/health
```

Kubernetes liveness probe.

```text
/ready
```

Kubernetes readiness probe.

```text
/metrics
```

Prometheus metrics.

## Helm Validation

Validate the chart:

```powershell
helm lint .\helm\student-app
```

Render development manifests:

```powershell
helm template student-app-dev `
  .\helm\student-app `
  -f .\helm\student-app\values-dev.yaml
```

Render production manifests:

```powershell
helm template student-app-prod `
  .\helm\student-app `
  -f .\helm\student-app\values-prod.yaml
```

## Image Repository

Update the image repository in the environment values file with the Amazon ECR repository URL.

Example:

```yaml
image:
  repository: 123456789012.dkr.ecr.ap-south-1.amazonaws.com/student-gitops-app
  tag: "v1"
```

Later GitHub Actions will automatically update the image tag in this GitOps repository after pushing a new image to ECR.