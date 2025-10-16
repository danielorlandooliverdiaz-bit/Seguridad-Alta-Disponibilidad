#!/bin/bash

search_public_keys() {
    echo "Introduce el directorio donde buscar claves públicas:"
    read -r search_dir
    echo "Buscando claves con extensión .pem, .pub, _public.pem:"
    find "${search_dir}" -type f \( -name "*.pem" -o -name "*.pub" -o -name "*_public.pem" \)
}
