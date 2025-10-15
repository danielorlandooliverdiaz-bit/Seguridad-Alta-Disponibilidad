#!/bin/bash

set -e

# Función para generar claves RSA
generate_keys() {
    echo "Introduce la ruta para guardar las claves (sin la extensión):"
    read -r key_path
    echo "Generando claves RSA de 2048 bits..."
    openssl genrsa -out "${key_path}_private.pem" 2048
    openssl rsa -in "${key_path}_private.pem" -pubout -out "${key_path}_public.pem"
    echo "Claves generadas en ${key_path}_private.pem y ${key_path}_public.pem"
}

# Función para cifrado simétrico
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

# Función para descifrado simétrico
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

# Función para cifrado híbrido
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

# Función para descifrado híbrido
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

# Función para visualizar una clave pública
view_public_key() {
    echo "Introduce la ruta de la clave pública a visualizar:"
    read -r key_path
    openssl rsa -pubin -in "${key_path}" -text -noout
}

# Función para buscar claves públicas
search_public_keys() {
    echo "Introduce el directorio donde buscar claves públicas:"
    read -r search_dir
    echo "Buscando claves con extensión .pem, .pub, _public.pem:"
    find "${search_dir}" -type f \( -name "*.pem" -o -name "*.pub" -o -name "*_public.pem" \)
}

# Función para importar una clave pública
import_public_key() {
    mkdir -p keyring
    echo "Introduce la ruta de la clave pública a importar:"
    read -r key_path
    cp "${key_path}" keyring/
    chmod 600 keyring/"$(basename "${key_path}")"
    echo "Clave importada a la carpeta 'keyring'"
}

# Función para exportar una clave pública
export_public_key() {
    echo "Introduce el nombre de la clave a exportar desde 'keyring':"
    read -r key_name
    echo "Introduce la ruta de destino:"
    read -r dest_path
    cp "keyring/${key_name}" "${dest_path}"
    echo "Clave exportada a ${dest_path}"
}

# Menú principal
while true; do
    echo "--- Menú de Operaciones OpenSSL ---"
    echo "1. Generar claves RSA"
    echo "2. Cifrado simétrico"
    echo "3. Descifrado simétrico"
    echo "4. Cifrado híbrido"
    echo "5. Descifrado híbrido"
    echo "6. Visualizar clave pública"
    echo "7. Buscar claves públicas"
    echo "8. Importar clave pública"
    echo "9. Exportar clave pública"
    echo "0. Salir"
    echo "-----------------------------------"
    echo -n "Elige una opción: "
    read -r option

    case $option in
        1) generate_keys ;;
        2) symmetric_encryption ;;
        3) symmetric_decryption ;;
        4) hybrid_encryption ;;
        5) hybrid_decryption ;;
        6) view_public_key ;;
        7) search_public_keys ;;
        8) import_public_key ;;
        9) export_public_key ;;
        0) break ;;
        *) echo "Opción no válida" ;;
    esac
done
