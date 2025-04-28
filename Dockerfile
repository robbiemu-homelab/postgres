FROM postgres:latest

# Copy the entrypoint and SQL template into the container
COPY preprocess.sh /usr/local/bin/preprocess.sh
COPY entrypoint.sh /usr/local/bin/custom_entrypoint.sh
COPY init-scripts/* /docker-entrypoint-initdb.d/

# Make both scripts executable
RUN chmod +x /usr/local/bin/preprocess.sh /usr/local/bin/custom_entrypoint.sh

# Set the custom entrypoint to our script
ENTRYPOINT ["/usr/local/bin/custom_entrypoint.sh"]
