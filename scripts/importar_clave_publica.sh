#!/bin/bash

import_public_key() {
    mkdir -p keyring
    echo "Introduce la ruta de la clave pública a importar:"
    read -r key_path
    cp "${key_path}" keyring/
    chmod 600 keyring/"$(basename "${key_path}")"
    echo "Clave importada a la carpeta 'keyring'"
}
