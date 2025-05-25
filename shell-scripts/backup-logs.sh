#!/bin/bash

# Variables
LOG_DIR="/var/log"
BACKUP_DIR="$HOME/log_backups"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="logs_backup_$TIMESTAMP.tar.gz"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Archive and compress logs
tar -czf "$BACKUP_DIR/$BACKUP_FILE" $LOG_DIR/*.log

# Confirmation
if [ $? -eq 0 ]; then
    echo "✅ Logs successfully backed up to $BACKUP_DIR/$BACKUP_FILE"
else
    echo "❌ Backup failed!"
fi
