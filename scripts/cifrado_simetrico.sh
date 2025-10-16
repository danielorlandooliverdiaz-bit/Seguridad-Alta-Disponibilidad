#!/bin/bash

symmetric_encryption() {
    echo "Introduce la ruta del archivo a cifrar:"
    read -r file_path
    local key_file="${file_path}.key.bin"
    echo "Generando clave aleatoria de 32 bytes en ${key_file}..."
    openssl rand -out "${key_file}" 32
    echo "Cifrando ${file_path} con AES-256..."
    openssl enc -aes-256-cbc -salt -in "${file_path}" -out "${file_path}.enc" -pass "file:${key_file}" -pbkdf2
    echo "Archivo cifrado en ${file_path}.enc. ¡Guarda ${key_file} para descifrar!"
}
