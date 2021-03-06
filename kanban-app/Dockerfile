#----------------------------------------------------------------------------
#Stage 0: Capa de gestor de dependencias
#----------------------------------------------------------------------------

#Obtención de imagen maven 3.6.1 para construir la aplicación y manejar sus dependencias
FROM maven:3.6.1-jdk-8-slim AS build

#Ejecución de comando para crear una carpeta para la carpeta de trabajo de la aplicación
RUN mkdir -p /workspace

#Establecimiento de carpeta de trabajo para la aplicación
WORKDIR /workspace

#Copiado de archivo pom.xml, quien maneja las dependencias, a la carpeta de trabajo
COPY pom.xml /workspace

#Copiado de codigo fuente de la aplicación en la carpeta de trabajo de la aplicación
COPY src /workspace/src

#Ejecución de comando de maven para coger el archivo de configuración pom.xml específico
#y construir la aplicación
RUN mvn -f pom.xml clean package

#----------------------------------------------------------------------------
#Stage 1: Capa de aplicación
#----------------------------------------------------------------------------

#Obtención de imagen openjdk 8 para ejecución de la aplicación
FROM openjdk:8-alpine

#Copiado de artefacto construido por maven en el stage "build" en su carpeta de trabajo
#para copiarlo en la capa aplicación con el nombre app.jar
COPY --from=build /workspace/target/*.jar app.jar

#Añadir metadados de la aplicación
LABEL maintainer="grupo9" \
    description="Aplicacion back-end | Grupo 9 Modulo Contenedores" \
    version="1.0"

#Configuración de variables de entorno para base de datos
ENV DB_SERVER="kanban-postgres"
ENV POSTGRES_DB="kanban"
ENV POSTGRES_USER="kanban"
ENV POSTGRES_PASSWORD="kanban"

#Exposición de puerto externo para el contenedor de la aplicación
EXPOSE 8080

#Ejecución de inicio de la aplicación bajo comando java
ENTRYPOINT ["java","-jar","app.jar"]