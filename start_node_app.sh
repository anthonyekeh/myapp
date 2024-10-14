#!/bin/bash
# Load system environment variables
source /etc/profile

# Define environment variables for the Node.js application
export DB_HOST='192.168.1.126'
export DB_USER='anthony'
export DB_PASSWORD='Huawei@1234##'
export DB_NAME='formdb'

# Navigate to the application directory
# cd /path/to/your/nodejs/application

# Start the Node.js application
# node app.js

# Optional: If using PM2 process manager to keep the app running
pm2 start app.js --name node-app

# Keep the container alive by showing PM2 logs
pm2 logs
