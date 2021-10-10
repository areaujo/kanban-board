#----------------------------------------------------------------------------
#Stage 0: Capa de gestor de dependencias
#----------------------------------------------------------------------------
### STAGE 1: Build ###

# Obtención de imagen node para construir la aplicación y manejar sus dependencias
FROM node:16-alpine AS build

#Creacion de volumen para aplicacion frontend
RUN mkdir /app-data
WORKDIR /app-data
VOLUME /app-data

# Establecimiento de carpeta de trabajo para la aplicación
WORKDIR /usr/src/app

# Copia del packege json donde se definen las dependencias de librerías
COPY package.json ./

# Variable de ambiente definida para la url del proyecto backend
ENV DEV_BACKEND_URL="http://localhost:8080"
ENV PROD_BACKEND_URL="http://localhost:8080/api"

# Comando para instalar las dependencias de librerías necesarias para el proyecto angular
RUN npm install

# Copia de los archivos del proyecto front-end al workdir
COPY . .

# Ejecución del comando build para el compilado del proyecto generando así la
# carpeta dist con los archivos compilados, es un comando para compilar en prod
RUN npm run build

#----------------------------------------------------------------------------
#Stage 1: Capa de aplicación
#----------------------------------------------------------------------------

# Obtención de imagen nginx para ejecución de la aplicación
FROM nginx:1.17.1-alpine

# Copiado del archivo de configuración del nginx para ubicación de la aplicación
COPY default.conf /etc/nginx/conf.d/default.conf

# Copiado de artefacto construido por npm build en el stage "build" en su carpeta de trabajo
# para copiarlo en la capa aplicación con el nombre kanban-ui
COPY --from=build /usr/src/app/dist/kanban-ui /usr/share/nginx/html

# Añadir metadados de la aplicación
LABEL maintainer="grupo9" \
    description="Aplicacion front-end | Grupo 9 Modulo Contenedores" \
    version="1.0"

# Exposición de puerto externo para el contenedor de la aplicación
EXPOSE 80