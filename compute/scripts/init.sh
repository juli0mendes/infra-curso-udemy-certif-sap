#!/bin/bash

# Update packages and install necessary software
yum update -y
yum install -y httpd
amazon-linux-extras install -y epel
yum install -y jq

# Enable and start Apache web server
systemctl enable httpd
systemctl start httpd

# Get a token for accessing instance metadata
TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

# Get instance metadata including the availability zone
INSTANCE_ID=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/instance-id)
AVAILABILITY_ZONE=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/placement/availability-zone)

# Create an index.html file
cat > /var/www/html/index.html <<EOF
<!DOCTYPE html>
<html>
<head>
    <title>EC2 Instance Info</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #f0f0f0;
        }
    </style>
</head>
<body>
    <h1>EC2 Instance Info</h1>
    <p><strong>Instance ID:</strong> ${INSTANCE_ID}</p>
    <p><strong>Availability Zone:</strong> ${AVAILABILITY_ZONE}</p>
</body>
</html>
EOF

# Set the appropriate permissions
chmod 644 /var/www/html/index.html
