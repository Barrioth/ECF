#!/bin/bash
set -e

APP_NAME="ecf-app"
IMAGE_NAME="$APP_NAME:latest"

echo "[INFO] Build Maven"
if [ -f "./mvnw" ]; then
    ./mvnw clean package -DskipTests
else
    mvn clean package -DskipTests
fi

echo "[INFO] Docker build"
docker build -t $IMAGE_NAME .

echo "[INFO] Déploiement sur Kubernetes"
kubectl apply -f deployment.yaml

echo "[INFO] Attente du déploiement"
kubectl rollout status deployment/$APP_NAME

echo "[INFO] Ressources déployées"
kubectl get pods
kubectl get svc
