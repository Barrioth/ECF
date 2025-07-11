# Étape 1 : build Angular
FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

RUN npx ng build --configuration=production

# Étape 2 : image finale avec NGINX
FROM nginx:stable-alpine

RUN rm -rf /usr/share/nginx/html/*

# Copie des fichiers buildés vers NGINX
COPY --from=builder /app/dist/hello-world/browser /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
