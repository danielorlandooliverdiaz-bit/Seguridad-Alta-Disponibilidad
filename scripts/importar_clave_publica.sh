#!/bin/bash

# Este script importa una clave pública a un directorio local llamado 'keyring',
# que funciona como un almacén de confianza para las claves de otros usuarios.

import_public_key() {
    # Crea el directorio 'keyring' si no existe.
    # El parámetro '-p' asegura que no haya error si el directorio ya existe.
    mkdir -p keyring

    # Pide al usuario la ruta del archivo de la clave pública que desea importar.
    echo "Introduce la ruta de la clave pública a importar:"
    read -r key_path

    # Copia el archivo de la clave pública al directorio 'keyring'.
    cp "${key_path}" keyring/

    # Cambia los permisos del archivo de la clave importada a 600 (lectura y escritura
    # solo para el propietario). Esto es una buena práctica de seguridad, aunque
    # se trate de una clave pública.
    # 'basename "${key_path}"' extrae solo el nombre del archivo de la ruta.
    chmod 600 keyring/"$(basename "${key_path}")"

    # Confirma que la clave ha sido importada correctamente.
    echo "Clave importada a la carpeta 'keyring'"
}
