#!/bin/bash
# Simula un pipeline CI/CD sencillo
echo "Iniciando pipeline manual..."
# Paso 1: Obtener el código más reciente (Source)
echo "Paso 1: Obteniendo código de GitHub..."
git pull origin main
# Paso 2: "Compilar" (simplemente verificar que los archivos estén presentes)
echo "Paso 2: Verificando archivos..."
if [ -f "index.html" ]; then
 echo "El archivo index.html existe. ¡Compilación exitosa!"
else
 echo "Error: No se encuentra el archivo index.html"
 exit 1
fi
# Paso 3: Desplegar (subir a S3)
echo "Paso 3: Desplegando a S3..."
BUCKET_NAME="mi-bucket-simple-pipeline-768328701735"
# Verificar si el bucket existe
aws s3 ls s3://$BUCKET_NAME
if [ $? -ne 0 ]; then
 echo "Creando bucket $BUCKET_NAME..."
 aws s3 mb s3://$BUCKET_NAME
 # Configurar el bucket para alojar un sitio web estático
 aws s3 website s3://$BUCKET_NAME --index-document index.html
fi
# Subir el archivo al bucket
aws s3 cp index.html s3://$BUCKET_NAME/index.html --acl public-read
# Verificar despliegue
echo "Sitio desplegado en: http://$BUCKET_NAME.s3-website-us-east-1.amazonaws.com"
echo "¡Pipeline completado con éxito!"
