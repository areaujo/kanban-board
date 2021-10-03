docker network create backend --driver bridge 

docker run --name kanban-postgres --network=backend -e POSTGRES_PASSWORD=kanban -e POSTGRES_DB=kanban -e POSTGRES_USER=kanban -v kanban-data:/var/lib/postgresql/data -d postgres:9.6-alpine

docker build -t kanban-app ./kanban-app/ 

docker run --name kanban-app --network=backend -p 8080:8080 -d kanban-app

docker build -t kanban-ui ./kanban-ui/ 

docker run --name kanban-ui --network=backend -p 8081:80 -d kanban-ui