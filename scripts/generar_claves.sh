#!/bin/bash

generate_keys() {
    echo "Introduce la ruta para guardar las claves (sin la extensión):"
    read -r key_path
    echo "Generando claves RSA de 2048 bits..."
    openssl genrsa -out "${key_path}_private.pem" 2048
    openssl rsa -in "${key_path}_private.pem" -pubout -out "${key_path}_public.pem"
    echo "Claves generadas en ${key_path}_private.pem y ${key_path}_public.pem"
}
