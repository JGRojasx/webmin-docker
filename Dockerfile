FROM debian:bookworm

LABEL maintainer="Webmin Docker Maintainer"
LABEL version="1.0"
LABEL description="Webmin Docker Container"

# Variables de entorno
ENV DEBIAN_FRONTEND=noninteractive

# Crear usuario no-root
RUN useradd -r -s /bin/false webmin

# Copiar scripts
COPY entrypoint.sh /entrypoint.sh
COPY webmin-setup-repo.sh /webmin-setup-repo.sh
COPY generate-password.sh /generate-password.sh
RUN chmod +x /entrypoint.sh /webmin-setup-repo.sh /generate-password.sh

# Instalación de dependencias y Webmin
RUN apt-get update -y \
    && touch /etc/apt/sources.list \
    && /webmin-setup-repo.sh --force \
    && apt-get install --no-install-recommends webmin -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Configurar volúmenes
VOLUME ["/etc/webmin", "/var/webmin"]



# Healthcheck
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost:10000/ || exit 1

EXPOSE 10000

CMD ["/entrypoint.sh"]
