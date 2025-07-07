#!/bin/bash

mvn clean package
docker build -t spring-hello .
docker run -d -p 8080:8080 --name spring-hello-container spring-hello

sleep 10

URL="http://localhost:8080/"
EXPECTED_CODE=200

echo "Test de santé de l'application à l'adresse $URL..."

# Faire la requête curl et récupérer le code HTTP
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$URL")

echo "Code HTTP reçu : $HTTP_CODE"

# Comparaison
if [ "$HTTP_CODE" -eq "$EXPECTED_CODE" ]; then
  echo "L'application répond correctement (HTTP $HTTP_CODE)"
  exit 0
else
  echo "Erreur : réponse inattendue (HTTP $HTTP_CODE)"
  exit 1
fi
 