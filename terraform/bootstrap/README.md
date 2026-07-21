# Terraform remote state bootstrap

Este módulo crea el bucket S3 versionado y la tabla DynamoDB utilizados por el backend remoto de Terraform.

Debe aplicarse **una sola vez y manualmente**, antes de inicializar o aplicar cualquier entorno:

```bash
cd terraform/bootstrap
terraform init
terraform apply
```

Después de crear estos recursos, inicializa el entorno con `terraform init -reconfigure` desde `terraform/environments/dev`.

No destruyas este módulo mientras existan entornos que dependan del state remoto.
