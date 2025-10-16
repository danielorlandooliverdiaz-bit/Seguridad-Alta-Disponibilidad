#!/bin/bash

symmetric_decryption() {
    echo "Introduce la ruta del archivo a descifrar (.enc):"
    read -r file_path
    local key_file="${file_path%.enc}.key.bin"
    echo "Introduce la ruta del archivo de clave (ej: ${key_file}):"
    read -r key_path_input
    echo "Descifrando ${file_path}..."
    openssl enc -d -aes-256-cbc -in "${file_path}" -out "${file_path%.enc}" -pass "file:${key_path_input}" -pbkdf2
    echo "Archivo descifrado en ${file_path%.enc}"
}
