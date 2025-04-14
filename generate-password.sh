#!/bin/bash

# Generar contraseña aleatoria segura
generate_password() {
    # Usar /dev/urandom para generar una contraseña aleatoria
    # Incluye caracteres especiales, números y letras
    local password=$(tr -dc 'A-Za-z0-9!@#$%^&*()_+{}|:<>?=' < /dev/urandom | head -c 16)
    echo "$password"
}

# Generar la contraseña
PASSWORD=$(generate_password)

# Cambiar la contraseña del usuario root
echo "root:${PASSWORD}" | chpasswd

# Mostrar mensaje de advertencia
echo "=============================================="
echo "¡ADVERTENCIA DE SEGURIDAD!"
echo "=============================================="
echo "La contraseña temporal del usuario root es: ${PASSWORD}"
echo "POR SEGURIDAD, CAMBIE ESTA CONTRASEÑA INMEDIATAMENTE"
echo "=============================================="
echo "Puede cambiar la contraseña accediendo a:"
echo "https://localhost:10000 -> Webmin -> Change Passwords"
echo "=============================================="

# Guardar la contraseña en un archivo temporal (solo para debugging)
echo "${PASSWORD}" > /tmp/root_password.txt
chmod 600 /tmp/root_password.txt 