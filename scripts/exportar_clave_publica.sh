#!/bin/bash

export_public_key() {
    echo "Introduce el nombre de la clave a exportar desde 'keyring':"
    read -r key_name
    echo "Introduce la ruta de destino:"
    read -r dest_path
    cp "keyring/${key_name}" "${dest_path}"
    echo "Clave exportada a ${dest_path}"
}
