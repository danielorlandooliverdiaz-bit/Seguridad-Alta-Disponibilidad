#!/bin/bash

set -e

# Source all script files
for script in scripts/*.sh; do
    source "$script"
done

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
