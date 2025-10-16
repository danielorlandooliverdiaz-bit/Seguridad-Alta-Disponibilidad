#!/bin/bash

# Este script permite visualizar el contenido de una clave pública en formato de texto.
# Es útil para verificar los detalles de una clave, como su módulo y exponente.

view_public_key() {
    # Pide al usuario que proporcione la ruta del archivo de la clave pública.
    echo "Introduce la ruta de la clave pública a visualizar:"
    read -r key_path

    # Utiliza OpenSSL para leer y mostrar la clave pública en formato de texto.
    # - 'rsa': Comando para el manejo de claves RSA.
    # - '-pubin': Indica que el archivo de entrada es una clave pública.
    # - '-in "${key_path}"': Especifica el archivo de la clave a leer.
    # - '-text': Muestra la clave en formato de texto legible.
    # - '-noout': Evita que se imprima la versión codificada de la clave.
    openssl rsa -pubin -in "${key_path}" -text -noout
}
