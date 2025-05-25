#!/bin/bash
threshold=80
usage=$(df -h / | grep -v Filesystem | awk '{print $5}' | sed 's/%//')

if [ $usage -gt $threshold ]; then
    echo "Disk usage is above $threshold%: $usage%"
    # You can send email or alert here
else
    echo "Disk usage is normal: $usage%"
fi
