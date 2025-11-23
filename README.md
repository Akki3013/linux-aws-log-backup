# linux-aws-log-backup
This project demonstrates Linux system administration and AWS integration. It automates daily backups of Apache logs from an EC2 instance and uploads them securely to an S3 bucket using a Bash script and cron jobs.

**Skills demonstrated:**
- Linux system administration (Apache, log management)
- Bash scripting
- Cron automation
- AWS CLI and S3 integration
- AWS IAM for secure programmatic access

---

## Project Features
1. **Automated backups** – Daily Apache log backups with timestamped directories.  
2. **S3 Integration** – Secure upload of logs to a private S3 bucket.  
3. **Cron job scheduling** – Fully automated execution without manual intervention.  
4. **Portfolio-ready** – Demonstrates real-world Linux + AWS workflow.

---

## Folder Structure
```
/home/ec2-user/
│
├── log_backup.sh          # Bash script to backup logs and upload to S3
└── log_backup/            # Directory where backups are stored
    └── 2025-11-20/        # Timestamped daily backup
        ├── access_log
        └── error_log
```



---

## Setup Instructions

### 1. Launch EC2 Instance
- Amazon Linux 2 
- Install Apache:
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd

2. Install AWS CLI
sudo yum install awscli -y

3. Configure AWS CLI
aws configure
Enter Access Key ID and Secret Access Key from IAM user
Default region
Default output format: json

4. Create S3 Bucket
Name must be globally unique
Keep bucket private

5. Create the Backup Script
nano ~/log_backup.sh

#!/bin/bash

TIMESTAMP=$(date +%F)
mkdir -p /home/ec2-user/log_backup/$TIMESTAMP
cp /var/log/httpd/* /home/ec2-user/log_backup/$TIMESTAMP/
echo "Backup completed for $TIMESTAMP"
aws s3 cp /home/ec2-user/log_backup/$TIMESTAMP/ s3://<your-bucket-name>/$TIMESTAMP/ --recursive
echo "Backup uploaded to S3 for $TIMESTAMP"
chmod +x ~/log_backup.sh

6. Test the Script
./log_backup.sh

8. Schedule Cron Job
crontab -e
0 0 * * * /home/ec2-user/log_backup.sh
   
Demonstration
Run the script manually to verify logs are backed up and uploaded to S3.

Check the S3 bucket → Timestamped folder contains access_log and error_log.

Outcome
Demonstrates full Linux + AWS automation workflow



