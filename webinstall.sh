#!/bin/bash
if [ ! -d "/root/rblxweb" ]; then
    echo "Please run the main installer then web client installer"
    exit 1
fi
echo "Roblox In Browser Server 2024-2024™ - WebClient"
echo "Starting To Cache"
echo "Verifying"
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. Please install Docker first."
    exit 1
fi
