# Multistage Dockerfile
# STEP 1: build the Angular static files
FROM node:13.2.0-alpine as builder

# Create app directory
WORKDIR /app

# Install app dependencies
COPY package.json package-lock.json /app/

# --no-optional not to try compile fsevent package
# That package is only needed on MacOS
RUN npm ci --no-optional --no-audit

# Copy project files into the docker image
COPY .  /app/
RUN npm install -g @angular/cli@9.1.1 --no-audit
RUN ng build --prod

# STEP 2: copy the static files and serve them with NGINX
FROM nginx:alpine

# Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*

# Copy NGINX configuration (for changing the port to 8080)
COPY default.conf /etc/nginx/conf.d/default.conf

# From 'builder' copy website to default nginx public folder
COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
