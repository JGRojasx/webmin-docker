# Webmin Docker

Este proyecto proporciona una imagen Docker para Webmin, una interfaz web para la administración de sistemas Unix.

## Características

- Basado en Debian Bookworm
- Versión configurable de Webmin
- Contraseña root generada aleatoriamente
- Healthcheck integrado
- Manejo de recursos limitado
- Reinicio automático
- Configuración mediante variables de entorno

## Requisitos

- Docker
- Docker Compose

## Uso

### Usando Docker Compose (Recomendado)

1. Clonar el repositorio:
```bash
git clone https://github.com/JGRojasx/webmin-docker.git
cd webmin-docker
```

2. Iniciar el contenedor:
```bash
docker-compose up -d
```

3. Acceder a Webmin:
```
https://localhost:10000
```

### Usando Docker directamente

```bash
docker build -t webmin .
docker run -d \
  -p 10000:10000 \
  --name webmin \
  webmin
```

## Variables de Entorno

Las siguientes variables de entorno están disponibles en el archivo `docker-compose.yml`:

- `TZ`: Zona horaria (por defecto: America/Caracas)

## Persistencia de Datos (Opcional)

Si deseas mantener la configuración y los datos de Webmin entre reinicios, puedes descomentar las siguientes líneas en el archivo `docker-compose.yml`:

```yaml
volumes:
  - webmin_config:/etc/webmin
  - webmin_data:/var/webmin
```

Y agregar la definición de volúmenes:

```yaml
volumes:
  webmin_config:
  webmin_data:
```

## Seguridad

- La contraseña del usuario root se genera aleatoriamente al iniciar el contenedor
- Se muestra un mensaje con la contraseña temporal y una advertencia para cambiarla
- El contenedor se ejecuta con un usuario no-root
- Los recursos están limitados para prevenir ataques de DoS

## Solución de Problemas

1. Verificar logs:
```bash
docker-compose logs webmin
```

2. Verificar estado del contenedor:
```bash
docker-compose ps
```

3. Verificar healthcheck:
```bash
docker inspect --format='{{json .State.Health}}' webmin
```


