FROM httpd:2.4

# Clear default web files
RUN rm -rf /usr/local/apache2/htdocs/*

# Copy your HTML file into the Apache server's root directory
COPY index.html /usr/local/apache2/htdocs/

# Copy your image into the Apache server's root directory
COPY dox2u-logo-black-text.png /usr/local/apache2/htdocs/

# Set working directory (optional)
WORKDIR /usr/local/apache2/htdocs/

# Expose port 80 to outside world
EXPOSE 80
