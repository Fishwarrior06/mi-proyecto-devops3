#!/bin/bash
echo "Iniciando monitoreo de cambios en el repositorio..."
cd mi-repositorio-devops3
while true; do
 echo "Verificando cambios..."
 git fetch
 LOCAL=$(git rev-parse HEAD)
 REMOTE=$(git rev-parse @{u})
 
 if [ $LOCAL != $REMOTE ]; then
 echo "¡Cambios detectados! Ejecutando pipeline..."
 ./simple-pipeline.sh
 else
 echo "No hay cambios. Esperando..."
 fi
 
 # Esperar 30 segundos antes de la próxima verificación
 sleep 30
done
