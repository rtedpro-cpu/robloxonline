#!/bin/bash
if [ ! -d "/root/rblxweb" ]; then
    echo "Please run the main installer then web client installer"
    exit 1
fi
echo "Roblox In Browser Server 2024-2024™ - WebClient"
echo "Starting To Cache"
echo "Verifying"
if [ ! -d "/usr/bin/docker" ]; then
    echo "Is Docker Installed?"
    exit 1
fi
