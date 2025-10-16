#!/bin/bash

# Este script busca claves públicas en un directorio especificado por el usuario.

search_public_keys() {
    # Solicita al usuario que introduzca el directorio donde buscar.
    echo "Introduce el directorio donde buscar claves públicas:"
    read -r search_dir

    # Informa al usuario sobre los tipos de archivos que se buscarán.
    echo "Buscando claves con extensión .pem, .pub, _public.pem:"

    # Utiliza el comando 'find' para buscar archivos que coincidan con los patrones de nombre.
    # - '${search_dir}': Es el directorio de búsqueda proporcionado por el usuario.
    # - '-type f': Busca solo archivos.
    # - '\( ... \)': Agrupa múltiples condiciones.
    # - '-name "*.pem"': Busca archivos que terminen en .pem.
    # - '-o': Representa un 'OR' lógico.
    # - '-name "*.pub"': Busca archivos que terminen en .pub.
    # - '-name "*_public.pem"': Busca archivos que terminen en _public.pem.
    find "${search_dir}" -type f \( -name "*.pem" -o -name "*.pub" -o -name "*_public.pem" \)
}
