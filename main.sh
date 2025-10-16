#!/bin/bash

# Importa todas las funciones de los scripts en el directorio 'scripts'.
for script in scripts/*.sh; do
    # shellcheck source=/dev/null
    source "$script"
done

# Función para mostrar el menú principal.
show_menu() {
    echo "========================================"
    echo "          MENÚ PRINCIPAL"
    echo "========================================"
    echo "1.  Generar un par de claves (pública/privada)"
    echo "2.  Buscar claves públicas disponibles"
    echo "3.  Importar clave pública"
    echo "4.  Exportar clave pública"
    echo "5.  Ver contenido de una clave pública"
    echo "----------------------------------------"
    echo "6.  Cifrado Simétrico"
    echo "7.  Descifrado Simétrico"
    echo "----------------------------------------"
    echo "8.  Cifrado Híbrido"
    echo "9.  Descifrado Híbrido"
    echo "----------------------------------------"
    echo "10. Salir"
    echo "========================================"
}

# Bucle principal del programa.
while true; do
    show_menu
    read -rp "Elige una opción [1-10]: " choice

    case $choice in
        1)
            generate_keys
            ;;
        2)
            search_public_keys
            ;;
        3)
            import_public_key
            ;;
        4)
            export_public_key
            ;;
        5)
            view_public_key
            ;;
        6)
            symmetric_encryption
            ;;
        7)
            symmetric_decryption
            ;;
        8)
            hybrid_encryption
            ;;
        9)
            hybrid_decryption
            ;;
        10)
            echo "Saliendo del programa."
            exit 0
            ;;
        *)
            echo "Opción no válida. Por favor, elige de nuevo."
            ;;
    esac

    # Pausa para que el usuario pueda leer el resultado antes de volver al menú.
    echo ""
    read -rp "Presiona Enter para continuar..."
done