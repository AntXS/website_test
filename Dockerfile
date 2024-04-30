# Use Ubuntu as base image
FROM ubuntu:latest

# Install Apache
RUN apt-get update && apt-get install -y apache2

COPY images/ /var/www/html/

COPY index.html /var/www/html/
# Expose port 80 for Apache
EXPOSE 80

# Start Apache service
CMD ["apachectl", "-D", "FOREGROUND"]

