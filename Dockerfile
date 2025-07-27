# Use Apache base image
FROM httpd:2.4

# Remove default html files
RUN rm -rf /usr/local/apache2/htdocs/*

# Copy your html files to Apache's html directory
COPY cafe.html /usr/local/apache2/htdocs/

# Expose port 80
EXPOSE 80
