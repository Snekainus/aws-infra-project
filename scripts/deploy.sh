#!/bin/bash
#!/bin/bash

echo "Initializing Terraform..."
terraform init

echo "Validating Terraform configuration..."
terraform validate

echo "Planning infrastructure changes..."
terraform plan -out=tfplan

echo "Applying infrastructure changes..."
terraform apply tfplan

echo "Deployment complete!"
