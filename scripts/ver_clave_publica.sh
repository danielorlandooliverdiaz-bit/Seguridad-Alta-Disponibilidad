#!/bin/bash

view_public_key() {
    echo "Introduce la ruta de la clave pública a visualizar:"
    read -r key_path
    openssl rsa -pubin -in "${key_path}" -text -noout
}
