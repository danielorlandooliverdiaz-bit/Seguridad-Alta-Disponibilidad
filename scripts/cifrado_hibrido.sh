#!/bin/bash

# Este script realiza un cifrado híbrido, combinando la eficiencia del cifrado
# simétrico (AES) con la seguridad del cifrado asimétrico (RSA).

hybrid_encryption() {
    # Solicita al usuario la ruta del archivo que desea cifrar.
    echo "Introduce la ruta del archivo a cifrar:"
    read -r file_path

    # Solicita la clave pública del destinatario para asegurar que solo él pueda descifrar.
    echo "Introduce la ruta de la clave pública RSA (.pem):"
    read -r public_key_path

    # Define los nombres de los archivos para la clave AES y la clave AES cifrada.
    local aes_key_file="${file_path}.aes.bin"
    local encrypted_aes_key_file="${file_path}.aes.bin.enc"

    # Genera una clave simétrica (AES de 256 bits) aleatoria y la guarda en un archivo.
    # Esta clave se usará para cifrar el archivo de gran tamaño, lo cual es mucho más
    # rápido que usar directamente un cifrado asimétrico.
    echo "Generando clave AES aleatoria..."
    openssl rand -out "${aes_key_file}" 32

    # Cifra el archivo principal utilizando AES-256 en modo CBC.
    # - '-salt': Añade una 'sal' para mayor seguridad.
    # - '-pass file:${aes_key_file}': Usa el contenido del archivo de la clave AES como contraseña.
    # - '-pbkdf2': Utiliza PBKDF2 para derivar la clave, un estándar robusto.
    echo "Cifrando el archivo con AES-256..."
    openssl enc -aes-256-cbc -salt -in "${file_path}" -out "${file_path}.enc" -pass "file:${aes_key_file}" -pbkdf2

    # Cifra la clave simétrica (AES) utilizando la clave pública RSA del destinatario.
    # Esto asegura que solo el poseedor de la clave privada correspondiente pueda
    # obtener la clave AES para descifrar el archivo.
    echo "Cifrando la clave AES con la clave pública RSA..."
    openssl pkeyutl -encrypt -in "${aes_key_file}" -pubin -inkey "${public_key_path}" -out "${encrypted_aes_key_file}"

    # Elimina la clave AES original (sin cifrar) para no dejar rastros.
    # La seguridad del sistema depende de que esta clave no sea accesible.
    rm "${aes_key_file}"

    # Informa al usuario dónde se encuentran el archivo cifrado y la clave cifrada.
    echo "Archivo cifrado en ${file_path}.enc y clave en ${encrypted_aes_key_file}"
}
