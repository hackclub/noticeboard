FROM nginx:alpine

# Install markdown processor (discount is the proper C implementation)
RUN apk add --no-cache discount

WORKDIR /app

# Copy the generation script
COPY generate.sh .

# Make generation script executable
RUN chmod +x generate.sh

EXPOSE 80

# Note: DISPLAY_TEXT should be set as a runtime environment variable in Coolify
# Don't set it as a build argument - it won't work with multiline values
# Default value if not provided at runtime:
ENV DISPLAY_TEXT="Welcome to Hack Club!"

# Generate HTML and serve with nginx
CMD ./generate.sh && cp /app/index.html /usr/share/nginx/html/index.html && nginx -g 'daemon off;'
