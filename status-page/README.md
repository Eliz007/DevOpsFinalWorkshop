# Status-Page Helm Chart

This Helm chart deploys the Status-Page application on a Kubernetes cluster using Amazon EKS.

## Prerequisites

- Kubernetes 1.19+
- Helm 3.0+
- Amazon EKS cluster
- PostgreSQL database (RDS recommended)
- Redis instance (ElastiCache recommended)
- AWS Load Balancer Controller installed

## Installation

### 1. Add the Helm repository (if using a repository)

```bash
helm repo add status-page https://your-helm-repo.com
helm repo update
```

### 2. Create a values file for your environment

```bash
cp helm-charts/status-page/values.yaml my-values.yaml
```

### 3. Update the values file with your configuration

Edit `my-values.yaml` and update the following sections:

```yaml
# Image configuration
image:
  repository: your-registry/status-page
  tag: "latest"

# Application configuration
app:
  secretKey: "your-secure-secret-key"
  database:
    name: "statuspage"
    user: "statuspage"
    password: "your-db-password"
    host: "your-rds-endpoint.amazonaws.com"
    port: 5432
  redis:
    tasks:
      host: "your-elasticache-endpoint.amazonaws.com"
      password: "your-redis-password"
    caching:
      host: "your-elasticache-endpoint.amazonaws.com"
      password: "your-redis-password"
  siteUrl: "https://status-page.yourdomain.com"

# Ingress configuration
ingress:
  enabled: true
  hosts:
    - host: status-page.yourdomain.com
      paths:
        - path: /
          pathType: Prefix
  annotations:
    alb.ingress.kubernetes.io/certificate-arn: arn:aws:acm:region:account:certificate/certificate-id
```

### 4. Install the chart

```bash
helm install status-page ./helm-charts/status-page -f my-values.yaml
```

### 5. Verify the installation

```bash
kubectl get pods -l app.kubernetes.io/name=status-page
kubectl get svc status-page
kubectl get ingress status-page
```

## Configuration

### Required Configuration

The following values must be configured for the application to work:

- `app.secretKey`: Django secret key
- `app.database.*`: PostgreSQL database configuration
- `app.redis.*`: Redis configuration
- `app.siteUrl`: Public URL of the application

### Optional Configuration

- `replicaCount`: Number of replicas (default: 3)
- `resources`: CPU and memory limits/requests
- `autoscaling`: Horizontal Pod Autoscaler configuration
- `ingress`: Ingress configuration for external access

## Values Reference

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| `replicaCount` | int | `3` | Number of replicas |
| `image.repository` | string | `"your-registry/status-page"` | Image repository |
| `image.tag` | string | `"latest"` | Image tag |
| `image.pullPolicy` | string | `"IfNotPresent"` | Image pull policy |
| `service.type` | string | `"ClusterIP"` | Service type |
| `service.port` | int | `80` | Service port |
| `service.targetPort` | int | `8000` | Target port |
| `ingress.enabled` | bool | `true` | Enable ingress |
| `ingress.className` | string | `"alb"` | Ingress class |
| `ingress.hosts` | list | `[{"host": "status-page.example.com", "paths": [{"path": "/", "pathType": "Prefix"}]}]` | Ingress hosts |
| `resources.limits.cpu` | string | `"500m"` | CPU limit |
| `resources.limits.memory` | string | `"1Gi"` | Memory limit |
| `resources.requests.cpu` | string | `"250m"` | CPU request |
| `resources.requests.memory` | string | `"512Mi"` | Memory request |
| `autoscaling.enabled` | bool | `false` | Enable autoscaling |
| `autoscaling.minReplicas` | int | `3` | Minimum replicas |
| `autoscaling.maxReplicas` | int | `10` | Maximum replicas |
| `app.secretKey` | string | `"your-secret-key-change-this-in-production"` | Django secret key |
| `app.debug` | bool | `false` | Debug mode |
| `app.database.name` | string | `"statuspage"` | Database name |
| `app.database.user` | string | `"statuspage"` | Database user |
| `app.database.password` | string | `"changeme"` | Database password |
| `app.database.host` | string | `"your-rds-endpoint.amazonaws.com"` | Database host |
| `app.database.port` | int | `5432` | Database port |
| `app.redis.tasks.host` | string | `"your-elasticache-endpoint.amazonaws.com"` | Redis tasks host |
| `app.redis.tasks.port` | int | `6379` | Redis tasks port |
| `app.redis.tasks.password` | string | `"changeme"` | Redis tasks password |
| `app.redis.caching.host` | string | `"your-elasticache-endpoint.amazonaws.com"` | Redis caching host |
| `app.redis.caching.port` | int | `6379` | Redis caching port |
| `app.redis.caching.password` | string | `"changeme"` | Redis caching password |
| `app.siteUrl` | string | `"https://status-page.example.com"` | Site URL |
| `healthCheck.enabled` | bool | `true` | Enable health checks |
| `healthCheck.path` | string | `"/api/health/"` | Health check path |
| `migration.enabled` | bool | `true` | Enable database migration |

## Upgrading

To upgrade the chart:

```bash
helm upgrade status-page ./helm-charts/status-page -f my-values.yaml
```

## Uninstalling

To uninstall the chart:

```bash
helm uninstall status-page
```

## Troubleshooting

### Check Pod Status

```bash
kubectl get pods -l app.kubernetes.io/name=status-page
```

### View Logs

```bash
kubectl logs -l app.kubernetes.io/name=status-page
```

### Check Health

```bash
kubectl port-forward svc/status-page 8000:80
curl http://localhost:8000/api/health/
```

### Database Migration Issues

```bash
# Check migration logs
kubectl logs -l app.kubernetes.io/name=status-page -c migrate

# Run migration manually
kubectl exec -it deployment/status-page -- python manage.py migrate
```

### Create Superuser

```bash
kubectl exec -it deployment/status-page -- python manage.py createsuperuser
```

### Collect Static Files

```bash
kubectl exec -it deployment/status-page -- python manage.py collectstatic --noinput
```

## Security Considerations

1. **Secrets Management**: Use AWS Secrets Manager or external secret management instead of Kubernetes secrets for production
2. **Network Policies**: Enable network policies to restrict pod-to-pod communication
3. **Pod Security Standards**: Ensure pods run with non-root users and minimal privileges
4. **Image Security**: Use specific image tags instead of `latest` and scan images for vulnerabilities
5. **TLS**: Always use HTTPS in production with proper SSL certificates

## Monitoring and Observability

### Health Checks

The application includes health checks at `/api/health/` that verify:
- Database connectivity
- Redis connectivity
- Returns HTTP 200 for healthy, 503 for unhealthy

### Metrics

Consider adding Prometheus metrics and Grafana dashboards for monitoring:
- Application performance metrics
- Database connection pool metrics
- Redis metrics
- Kubernetes resource utilization

### Logging

- Application logs are sent to stdout for Kubernetes log aggregation
- Consider using Fluentd or similar for log forwarding to external systems
- Use structured logging for better log analysis

## Production Checklist

- [ ] Update all default passwords and secrets
- [ ] Configure proper SSL certificates
- [ ] Set up monitoring and alerting
- [ ] Configure backup strategies for database
- [ ] Test disaster recovery procedures
- [ ] Set up log aggregation
- [ ] Configure network policies
- [ ] Review and update resource limits
- [ ] Test scaling procedures
- [ ] Document operational procedures
