# Step 1: Base image
FROM ubuntu:20.04

# Step 2: Set environment variables for non-interactive apt installs
ENV DEBIAN_FRONTEND=noninteractive

# Step 3: Install Node.js, PM2, and other dependencies
RUN apt-get update && apt-get install -y \
    curl \
    gnupg2 \
    build-essential

# Step 4: Install Node.js and npm (v14.x or the desired version)
RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs

# Step 5: Install PM2 globally
RUN npm install -g pm2

# Step 6: Create and set the working directory
WORKDIR /usr/src/app

# Step 7: Copy the package.json and package-lock.json (if present)
COPY package*.json ./

# Step 8: Install Node.js dependencies
RUN npm install

# Step 9: Copy the rest of the application code into the container
COPY . .

# Step 10: Copy the startup script to the container and make it executable
COPY start_node_app.sh /usr/src/app/start_node_app.sh
RUN chmod +x /usr/src/app/start_node_app.sh

# Step 11: Expose the application port (for example, port 3000)
EXPOSE 3000

# Step 12: Define the startup command (PM2 start via your script)
CMD ["./start_node_app.sh"]
