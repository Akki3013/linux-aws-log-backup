#!/bin/bash

# Create a timestamped backup directory
TIMESTAMP=$(date +%F)
mkdir -p /home/ec2-user/log_backup/$TIMESTAMP

# Copy Apache logs
cp /var/log/httpd/* /home/ec2-user/log_backup/$TIMESTAMP/

echo "Backup completed for $TIMESTAMP"

# Upload backup to S3 (replace with your bucket name)
aws s3 cp /home/ec2-user/log_backup/$TIMESTAMP/ s3://my-linux-backup-2025-unique123/$TIMESTAMP/ --recursive
echo "Backup uploaded to S3 for $TIMESTAMP"
