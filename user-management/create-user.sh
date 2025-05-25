#!/bin/bash

# Check for root privileges
if [[ $EUID -ne 0 ]]; then
   echo "❌ This script must be run as root (sudo)" 
   exit 1
fi

# Check if username is provided
if [ -z "$1" ]; then
  echo "Usage: $0 username [group]"
  exit 1
fi

USERNAME=$1
GROUP=${2:-sudo}   # Default group sudo if not provided
PASSWORD="ChangeMe123!"  # Default password — change as needed

# Create user and add to group
useradd -m -G "$GROUP" "$USERNAME"

if [ $? -eq 0 ]; then
  echo "✅ User $USERNAME created and added to group $GROUP."
else
  echo "❌ Failed to create user $USERNAME."
  exit 1
fi

# Set password for user
echo "$USERNAME:$PASSWORD" | chpasswd

if [ $? -eq 0 ]; then
  echo "✅ Password set for user $USERNAME."
else
  echo "❌ Failed to set password for $USERNAME."
fi

# Force password change on first login
chage -d 0 "$USERNAME"

echo "ℹ️ User must change password on first login."
