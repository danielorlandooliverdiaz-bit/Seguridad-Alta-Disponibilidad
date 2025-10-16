#!/bin/bash

# Este script se encarga de generar un par de claves RSA: una privada y una pública.
# Las claves RSA son fundamentales para el cifrado asimétrico.

generate_keys() {
    # Pide al usuario que especifique una ruta base para guardar los archivos de las claves.
    echo "Introduce la ruta para guardar las claves (sin la extensión):"
    read -r key_path

    # Informa al usuario que se están generando las claves con una longitud de 2048 bits.
    # Esta longitud de clave se considera segura para la mayoría de los propósitos.
    echo "Generando claves RSA de 2048 bits..."

    # Genera la clave privada RSA.
    # - 'genrsa': Es el comando de OpenSSL para generar claves RSA.
    # - '-out "${key_path}_private.pem"': Especifica el archivo de salida para la clave privada.
    # - '2048': Es la longitud de la clave en bits.
    openssl genrsa -out "${key_path}_private.pem" 2048

    # Extrae la clave pública de la clave privada.
    # - 'rsa': Es el comando para manejar claves RSA.
    # - '-in "${key_path}_private.pem"': Especifica el archivo de entrada (la clave privada).
    # - '-pubout': Indica que se debe extraer la clave pública.
    # - '-out "${key_path}_public.pem"': Especifica el archivo de salida para la clave pública.
    openssl rsa -in "${key_path}_private.pem" -pubout -out "${key_path}_public.pem"

    # Confirma al usuario que las claves han sido creadas y dónde se encuentran.
    echo "Claves generadas en ${key_path}_private.pem y ${key_path}_public.pem"
}
