#!/bin/bash

# Health check script for Linux VM

# Check CPU usage
echo "Checking CPU usage..."
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
echo "CPU Usage: $cpu_usage%"

# Check Memory usage
echo "Checking Memory usage..."
mem_usage=$(free -m | awk 'NR==2{printf "Memory Usage: %.2f%%\n", $3*100/$2 }')
echo $mem_usage

# Check Disk usage
echo "Checking Disk usage..."
disk_usage=$(df -h | awk '$NF=="/"{printf "Disk Usage: %s\n", $5}')
echo $disk_usage

# Check Network status
echo "Checking Network status..."
network_status=$(ping -c 1 google.com &> /dev/null && echo "Network is up" || echo "Network is down")
echo $network_status

# Check if essential services are running (e.g., ssh, apache2)
echo "Checking essential services..."
services=("ssh" "apache2")
for service in "${services[@]}"
do
    if systemctl is-active --quiet $service; then
        echo "$service is running"
    else
        echo "$service is not running"
    fi
done

# Print a summary
echo "Health check completed."
