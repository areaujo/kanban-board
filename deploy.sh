#!/bin/sh

#Constantes de variables para script
BLUE_COLOR='\033[0;34m'
NO_COLOR='\033[0m'

#Creacion de red para la aplicacion backend de tipo bridge
echo -e "${BLUE_COLOR}Creacion de network: backend${NO_COLOR}"

docker network create \
	backend \
	--driver bridge
	
#Ejecucion de contenedor para la base de datos postgres con las siguientes consideraciones:
# - Especificacion de red backend para no ser accesible fuera de la red especificada
# - Configuracion de variable de entorno para la contraseña de la base de datos
# - Configuracion de volumen al directorio local donde se ejecutan los scripts de tipo bind
# - Configuracion de credenciales de base de datos
# - Configuración de reinicio siempre para que el servicio funcione siempre
echo -e "${BLUE_COLOR}Creacion y ejecucion de contenedor: postgres${NO_COLOR}"

docker run \
	--name kanban-postgres \
	-e POSTGRES_DB=kanban \
	-e POSTGRES_USER=kanban \
	-e POSTGRES_PASSWORD=kanban \
	-p 5432:5432 \
	--mount type=bind,source="$(pwd)/database-data",target=/var/lib/postgresql/data \
	--network=backend \
	--restart always \
	-d postgres:9.6-alpine

#Creacion de imagen para aplicacion backend con las siguientes consideraciones:
# - Especificacion de ruta de docker file
# - Especificacion de nombre y version de imagen
# - Especificacion de ruta a usar
echo -e "${BLUE_COLOR}Creacion de imagen: kanban-app:latest${NO_COLOR}"

docker build -f kanban-app/Dockerfile -t kanban-app:latest kanban-app/

#Ejecucion de contenedor para la aplicacion backend con las siguientes consideraciones:
# - Configuracion de nombre de contenedor
# - Configuracion de puerto 8080 para exposicion del contenedor y puerto 8080 como interna para la aplicacion
# - Especificacion de red backend para no ser accesible fuera de la red especificada
# - Configuración de reinicio siempre para que el servicio funcione siempre
# - Configuracion para ejecucion en background
echo -e "${BLUE_COLOR}Creacion de imagen: kanban-app:latest${NO_COLOR}"

docker run \
	--name kanban-app \
	--network=backend \
	-p 8080:8080 \
	--restart always \
	-d kanban-app

#Creacion de imagen para aplicacion frontend con las siguientes consideraciones:
# - Especificacion de ruta de docker file
# - Especificacion de nombre y version de imagen
# - Especificacion de ruta a usar
echo -e "${BLUE_COLOR}Creacion de imagen: kanban-ui:latest${NO_COLOR}"

docker build -f kanban-ui/Dockerfile -t kanban-ui:latest kanban-ui/

#Ejecucion de contenedor para la aplicacion frontend con las siguientes consideraciones:
# - Configuracion de nombre de contenedor
# - Configuracion de puerto 8081 para exposicion del contenedor y puerto 80 como interna para la aplicacion
# - Especificacion de red backend para no ser accesible fuera de la red especificada
# - Configuración de reinicio siempre para que el servicio funcione siempre
# - Configuracion para ejecucion en background
echo -e "${BLUE_COLOR}Creacion y ejecucion de contenedor: result_app${NO_COLOR}"

docker run \
	--name kanban-ui \
	--network=backend \
	-p 8081:80 \
	--restart always \
	-d kanban-ui