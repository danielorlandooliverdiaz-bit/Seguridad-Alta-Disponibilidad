#!/bin/bash

# Este script exporta una clave pública desde el directorio 'keyring' a una
# ubicación de destino especificada por el usuario.

export_public_key() {
    # Pide al usuario el nombre de la clave que desea exportar.
    # Se asume que esta clave se encuentra en el directorio 'keyring'.
    echo "Introduce el nombre de la clave a exportar desde 'keyring':"
    read -r key_name

    # Pide al usuario la ruta completa donde se guardará la clave exportada.
    echo "Introduce la ruta de destino:"
    read -r dest_path

    # Copia el archivo de la clave desde el 'keyring' al destino.
    cp "keyring/${key_name}" "${dest_path}"

    # Confirma que la clave ha sido exportada.
    echo "Clave exportada a ${dest_path}"
}
