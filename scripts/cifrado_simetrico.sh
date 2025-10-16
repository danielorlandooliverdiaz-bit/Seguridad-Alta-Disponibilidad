#!/bin/bash

# Este script realiza un cifrado simétrico utilizando AES-256.
# El cifrado simétrico usa la misma clave para cifrar y descifrar.

symmetric_encryption() {
    # Solicita al usuario la ruta del archivo que desea cifrar.
    echo "Introduce la ruta del archivo a cifrar:"
    read -r file_path

    # Define el nombre del archivo que contendrá la clave de cifrado.
    local key_file="${file_path}.key.bin"

    # Genera una clave aleatoria de 32 bytes (256 bits) y la guarda en el archivo de clave.
    # Es crucial guardar esta clave en un lugar seguro, ya que sin ella no se puede
    # descifrar el archivo.
    echo "Generando clave aleatoria de 32 bytes en ${key_file}..."
    openssl rand -out "${key_file}" 32

    # Cifra el archivo utilizando el algoritmo AES-256 en modo CBC.
    # - '-aes-256-cbc': Especifica el algoritmo de cifrado.
    # - '-salt': Añade una 'sal' aleatoria para fortalecer el cifrado contra ataques de diccionario.
    # - '-in "${file_path}"': Es el archivo de entrada a cifrar.
    # - '-out "${file_path}.enc"': Es el archivo de salida donde se guardará el contenido cifrado.
    # - '-pass file:${key_file}': Utiliza el contenido del archivo de clave como la contraseña.
    # - '-pbkdf2': Utiliza la función de derivación de claves PBKDF2 para mayor seguridad.
    echo "Cifrando ${file_path} con AES-256..."
    openssl enc -aes-256-cbc -salt -in "${file_path}" -out "${file_path}.enc" -pass "file:${key_file}" -pbkdf2

    # Informa al usuario que el archivo ha sido cifrado y le recuerda guardar la clave.
    echo "Archivo cifrado en ${file_path}.enc. ¡Guarda ${key_file} para descifrar!"
}
