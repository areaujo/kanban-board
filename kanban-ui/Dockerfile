#----------------------------------------------------------------------------
#Stage 0: Capa de instalación y ejecución de aplicación front-end
#----------------------------------------------------------------------------

#Obtención de node 12.7 para construir y ejecutar la aplicación
#tiene como nombre build
FROM node:12.7-alpine AS build

#Establecimiento de carpeta de trabajo para la aplicación
WORKDIR /usr/src/app

#Copiar archivo de configuración de la aplicación a la raíz del contenedor
COPY package.json ./

#Ejecución de comando de instalación de dependencias de la aplicación, 
#con la herramienta npm
RUN npm install

#Copiar todo el contenido de la aplicación a contenedor
COPY . .

#Construcción de la aplicación
ENTRYPOINT ["npm","run","build"]

#----------------------------------------------------------------------------
#Stage 1: Capa de servidor web para la aplicación front-end
#----------------------------------------------------------------------------

#Obtención de servidor web nginx 1.17.1 para enrutamiento de trafico
#de la aplicacion
FROM nginx:1.17.1-alpine

#Copiado de configuración para servidor web hacia ruta donde se instaló
#la imagen del contenedor
COPY default.conf /etc/nginx/conf.d/default.conf

#Copiado de artefacto construir de la aplicación hacia servidor web
#para su publicación
COPY --from=build /usr/src/app/dist/kanban-ui /usr/share/nginx/html

#Configuración de variables de entorno para comunicación con aplicación back-end
ENV API_URL_DEV="http://localhost:8080" \
    API_URL_PROD="/api"

#Exposición de puerto de servidor web para acceso a la aplicación
EXPOSE 8081