#!/bin/bash

# Este script realiza el descifrado híbrido.
# Primero, descifra la clave simétrica (AES) utilizando la clave privada (RSA).
# Luego, utiliza la clave simétrica descifrada para descifrar el archivo.

hybrid_decryption() {
    # Pide al usuario la ruta del archivo cifrado.
    echo "Introduce la ruta del archivo a descifrar (.enc):"
    read -r file_path

    # Pide la clave privada, necesaria para descifrar la clave de sesión (AES).
    echo "Introduce la ruta de la clave privada RSA (.pem):"
    read -r private_key_path

    # Define los nombres de los archivos para la clave AES y la clave AES cifrada.
    # Se usa la expansión de parámetros de Bash `${file_path%.enc}` para quitar
    # la extensión .enc y formar el nombre base.
    local aes_key_file="${file_path%.enc}.aes.bin"
    local encrypted_aes_key_file="${file_path%.enc}.aes.bin.enc"

    # Descifra la clave de sesión AES utilizando la clave privada RSA.
    # Solo el poseedor de la clave privada puede realizar este paso.
    echo "Descifrando la clave AES..."
    openssl pkeyutl -decrypt -in "${encrypted_aes_key_file}" -inkey "${private_key_path}" -out "${aes_key_file}"

    # Una vez obtenida la clave AES, se utiliza para descifrar el archivo principal.
    # Los parámetros deben coincidir con los usados en el cifrado.
    # -d: indica que se va a descifrar
    echo "Descifrando el archivo..."
    openssl enc -d -aes-256-cbc -in "${file_path}" -out "${file_path%.enc}" -pass "file:${aes_key_file}" -pbkdf2

    # Elimina la clave AES en texto plano para no dejarla expuesta.
    rm "${aes_key_file}"

    # Informa al usuario que el archivo ha sido descifrado.
    echo "Archivo descifrado en ${file_path%.enc}"
}
