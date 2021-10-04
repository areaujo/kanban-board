#!/bin/sh

#Constantes de variables para script
BLUE_COLOR='\033[0;34m'
NO_COLOR='\033[0m'

#Consideraciones:
# - No opte por borrar las imagenes de los contenedores por fines de pruebas con el ejercicio

#Borrado de contenedores creados y en ejecucion con las siguientes consideraciones:
# - Forzado de borrado de contenedores sin importar si estan en ejecucion
# - Borrado de volumenes anonimos que algunos contenedores crearon
echo -e "${BLUE_COLOR}Eliminacion de contenedores y volumes anonimos de los mismos${NO_COLOR}"

docker rm --force --volumes kanban-ui kanban-app kanban-postgres

#Borrado de volumenes creados
echo -e "${BLUE_COLOR}Eliminacion de volumes${NO_COLOR}"

docker volume rm app-data

#Borrado de redes creadas
echo -e "${BLUE_COLOR}Eliminacion de networks${NO_COLOR}"

docker network rm backend