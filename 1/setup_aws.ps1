# -------- CLUSTER KUBERNETES (EKS) --------
eksctl create cluster `
  --name MonClusterEKS `
  --region eu-west-3 `
  --nodegroup-name workers `
  --nodes 2 `
  --node-type t3.small `
  --managed

kubectl get nodes

# -------- FONCTION SERVERLESS LAMBDA --------
# Créer le fichier source si absent
"def lambda_handler(event, context):`n    return {`n        'statusCode': 200,`n        'body': 'Hello from Lambda!'`n    }" | Out-File -Encoding utf8 lambda_function.py

# Créer le ZIP
Compress-Archive -Path lambda_function.py -DestinationPath lambda.zip -Force

# Créer la fonction Lambda
aws lambda create-function `
  --function-name HelloLambda `
  --runtime python3.12 `
  --role arn:aws:iam::677273281507:role/AWSLambdaBasicExecutionRole `
  --handler lambda_function.lambda_handler `
  --zip-file fileb://lambda.zip `
  --region eu-west-3

# Tester la fonction
aws lambda invoke `
  --function-name HelloLambda `
  --payload '{}' `
  --region eu-west-3 `
  output.json

Get-Content output.json
