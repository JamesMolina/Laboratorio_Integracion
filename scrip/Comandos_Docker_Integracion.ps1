# ULEAM - PLATAFORMAS - Integracion de Contenedores

# 01. VERIFICACION DE INSTALACIONES
wsl --status
wsl -l -v
wsl --install -d Ubuntu
docker version
docker --version
docker info
docker compose version

# 02. DESCARGAR IMAGENES
docker pull redis:7-alpine
docker pull postgres:16-alpine
docker pull alpine:latest
docker images

# 03. CREAR Y EJECUTAR REDIS
docker run redis:7-alpine
docker run -d --name mi-redis redis:7-alpine
docker run --name infra-redis -p 6379:6379 -v vol_redis_datos:/data --restart unless-stopped redis:7-alpine redis-server --appendonly yes
docker run -d --name infra-redis -p 6379:6379 -v vol_redis_datos:/data --restart unless-stopped redis:7-alpine redis-server --appendonly yes


# 04. VER CONTENEDORES Y PUERTOS
docker ps
docker ps -a
docker ps --format "table {{.ID}}\t{{.Status}}\t{{.Ports}}"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
docker port infra-redis
docker port compose-redis

# 05. DETENER, INICIAR Y ELIMINAR CONTENEDORES
docker stop infra-redis
docker start infra-redis
docker stop infra-redis7
docker rm infra-redis
docker rm -f infra-redis
docker ps -a


# 06. VOLUMENES Y PERSISTENCIA
docker volume create vol_redis_datos
docker volume ls
docker volume inspect vol_redis_datos
docker run --rm -v vol_redis_datos:/datos alpine ls -lah /datos
docker volume ls

# 07. REDIS: ENTRAR AL CONTENEDOR Y ABRIR REDIS-CLI
docker exec -it infra-redis sh
Una vez dentro del shell del contenedor, escribir: redis-cli
Alternativa directa desde PowerShell:
docker exec -it infra-redis redis-cli
Probar conectividad Redis desde PowerShell:
docker exec infra-redis redis-cli PING
docker exec compose-redis redis-cli PING
docker exec -it compose-redis redis-cli

# 08. REDIS: GUARDAR, LEER, MODIFICAR Y PERSISTIR DATOS
Dentro de redis-cli se utilizaron estos comandos:
SET asignatura "Integracion TI"
SET alumno "Gabriel Zambrano"
GET asignatura
GET alumno
SET asignatura "Integracion"
GET asignatura
GET alumno
SAVE

# 09. Copiar solo el directorio AOF desde el contenedor:
docker cp infra-redis:/data/appendonlydir/. .\backup_redis
explorer .\backup_redis

# 10. DOCKER COMPOSE (requiere docker-compose.yaml en la carpeta actual)
docker compose config
docker compose up -d
docker compose ps
docker compose logs --tail 30
docker compose logs -f --tail 30
docker compose stop
docker compose start
docker compose down


# 111. GIT - VERSIONAMIENTO DE LA PRACTICA
git init
git status
git add .
git config --global user.name "Jose Gabriel Zambrano Burgos"
git config --global user.email "gabrielrebelde8@gmail.com"
git commit -m "Init"


# 13. RECORDATORIO DE PUERTOS Y VOLUMENES
Redis:      6379 (contenedor) -> 6379
PostgreSQL: 5432 (contenedor) -> 5432 
Volumen Redis Compose: vol_compose_redis:/data
Volumen PostgreSQL Compose: vol_compose_postgres:/var/lib/postgresql/data
La ruta /var/lib/docker/volumes/.../_data pertenece al entorno Docker,

