#!/bin/bash

hybrid_encryption() {
    echo "Introduce la ruta del archivo a cifrar:"
    read -r file_path
    echo "Introduce la ruta de la clave pública RSA (.pem):"
    read -r public_key_path
    local aes_key_file="${file_path}.aes.bin"
    local encrypted_aes_key_file="${file_path}.aes.bin.enc"
    echo "Generando clave AES aleatoria..."
    openssl rand -out "${aes_key_file}" 32
    echo "Cifrando el archivo con AES-256..."
    openssl enc -aes-256-cbc -salt -in "${file_path}" -out "${file_path}.enc" -pass "file:${aes_key_file}" -pbkdf2
    echo "Cifrando la clave AES con la clave pública RSA..."
    openssl pkeyutl -encrypt -in "${aes_key_file}" -pubin -inkey "${public_key_path}" -out "${encrypted_aes_key_file}"
    rm "${aes_key_file}"
    echo "Archivo cifrado en ${file_path}.enc y clave en ${encrypted_aes_key_file}"
}
