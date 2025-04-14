#!/bin/bash
set -e

# Función para limpiar al salir
cleanup() {
    echo "Deteniendo Webmin..."
    /etc/init.d/webmin stop
    exit 0
}

# Capturar señales de terminación
trap cleanup SIGTERM SIGINT

# Generar contraseña aleatoria si no existe
if [ ! -f /tmp/root_password.txt ]; then
    /generate-password.sh
fi

# Iniciar Webmin
echo "Iniciando Webmin..."
/etc/init.d/webmin start

# Verificar que Webmin está corriendo
if [ ! -f /var/webmin/miniserv.pid ]; then
    echo "Error: Webmin no se inició correctamente"
    exit 1
fi

# Monitorear el proceso
PID=$(< /var/webmin/miniserv.pid)
tail --pid=$PID -f /var/webmin/miniserv.error
