#!/bin/bash

hybrid_decryption() {
    echo "Introduce la ruta del archivo a descifrar (.enc):"
    read -r file_path
    echo "Introduce la ruta de la clave privada RSA (.pem):"
    read -r private_key_path
    local aes_key_file="${file_path%.enc}.aes.bin"
    local encrypted_aes_key_file="${file_path%.enc}.aes.bin.enc"
    echo "Descifrando la clave AES..."
    openssl pkeyutl -decrypt -in "${encrypted_aes_key_file}" -inkey "${private_key_path}" -out "${aes_key_file}"
    echo "Descifrando el archivo..."
    openssl enc -d -aes-256-cbc -in "${file_path}" -out "${file_path%.enc}" -pass "file:${aes_key_file}" -pbkdf2
    rm "${aes_key_file}"
    echo "Archivo descifrado en ${file_path%.enc}"
}
