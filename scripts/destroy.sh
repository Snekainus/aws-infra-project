#!/bin/bash

echo "Destroying infrastructure..."
terraform destroy -auto-approve

echo "Cleanup complete!"
