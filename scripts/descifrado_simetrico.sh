#!/bin/bash

# Este script se encarga de descifrar un archivo que fue cifrado previamente
# con un método simétrico (AES-256).

symmetric_decryption() {
    # Pide al usuario la ruta del archivo que quiere descifrar (el que tiene extensión .enc).
    echo "Introduce la ruta del archivo a descifrar (.enc):"
    read -r file_path

    # Sugiere un nombre para el archivo de clave, basándose en el nombre del archivo cifrado.
    # Esto es una ayuda para el usuario, que podría haber olvidado dónde guardó la clave.
    local key_file="${file_path%.enc}.key.bin"
    echo "Introduce la ruta del archivo de clave (ej: ${key_file}):"
    read -r key_path_input

    # Inicia el proceso de descifrado.
    echo "Descifrando ${file_path}..."

    # Llama a OpenSSL para realizar el descifrado.
    # - '-d': Indica que la operación es de descifrado.
    # - '-aes-256-cbc': Especifica el algoritmo, que debe ser el mismo que se usó para cifrar.
    # - '-in "${file_path}"': Es el archivo de entrada cifrado.
    # - '-out "${file_path%.enc}"': Es el archivo de salida donde se guardará el contenido descifrado.
    #   Se utiliza la expansión de parámetros de Bash para quitar la extensión .enc.
    # - '-pass file:${key_path_input}': Usa el contenido del archivo de clave proporcionado como contraseña.
    # - '-pbkdf2': Especifica que se debe usar PBKDF2, igual que en el cifrado.
    openssl enc -d -aes-256-cbc -in "${file_path}" -out "${file_path%.enc}" -pass "file:${key_path_input}" -pbkdf2

    # Informa al usuario que el archivo ha sido descifrado y dónde encontrarlo.
    echo "Archivo descifrado en ${file_path%.enc}"
}
