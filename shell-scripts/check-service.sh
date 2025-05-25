#!/bin/bash

# Service name passed as an argument
SERVICE=$1

if [ -z "$SERVICE" ]; then
    echo "Usage: $0 <service-name>"
    exit 1
fi

# Check service status
if systemctl is-active --quiet "$SERVICE"; then
    echo "✅ $SERVICE is running."
else
    echo "⚠️ $SERVICE is not running. Attempting to restart..."
    sudo systemctl restart "$SERVICE"

    # Recheck
    if systemctl is-active --quiet "$SERVICE"; then
        echo "✅ $SERVICE restarted successfully."
    else
        echo "❌ Failed to restart $SERVICE."
    fi
fi
