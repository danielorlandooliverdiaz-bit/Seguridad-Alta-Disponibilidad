#!/bin/bash

# Script para probar las funcionalidades principales de la aplicación de cifrado.
# Ejecuta este script desde tu terminal con: ./run_tests.sh

# Detiene el script si algún comando falla
set -e

echo "================================================="
echo "        INICIANDO PRUEBA COMPLETA"
echo "================================================="

# --- 1. PREPARACIÓN ---
echo "
--- Paso 1: Preparando entorno de prueba... ---"
# Eliminar archivos de ejecuciones anteriores para un inicio limpio
rm -f my_test_keys* test_file* key.bin* aes_key.bin* decrypted_* hybrid_test_file.txt.enc
echo "Archivos antiguos eliminados."
# Crear un archivo de ejemplo para cifrar
echo "Este es un mensaje ultra secreto para la prueba." > test_file.txt
echo "Archivo de prueba creado: 'test_file.txt'"
cat test_file.txt

# --- 2. GENERACIÓN DE CLAVES ---
echo "
--- Paso 2: Probando '1. Generar claves RSA'... ---"
# Se simula la entrada del usuario: "1" para la opción y "my_test_keys" para el nombre.
echo -e "1\nmy_test_keys" | ./main.sh
echo "Claves 'my_test_keys_private.pem' y 'my_test_keys_public.pem' deberían haber sido creadas."
ls my_test_keys*

# --- 3. CIFRADO Y DESCIFRADO SIMÉTRICO ---
echo "
--- Paso 3: Probando '6. Cifrado Simétrico'... ---"
# Se simula la entrada del usuario: "6" para la opción y "test_file.txt" para el archivo.
echo -e "6\ntest_file.txt" | ./main.sh
echo "Archivos 'test_file.txt.enc' y 'key.bin' deberían haber sido creados."
ls test_file.txt.enc key.bin

echo "
--- Paso 4: Probando '7. Descifrado Simétrico'... ---"
# Se simula la entrada del usuario: "7" para la opción y "test_file.txt.enc" para el archivo.
echo -e "7\ntest_file.txt.enc" | ./main.sh
# El script de descifrado crea un archivo con el prefijo "decrypted_"
mv decrypted_test_file.txt.enc decrypted_symmetric_result.txt
echo "Archivo descifrado: 'decrypted_symmetric_result.txt'"
cat decrypted_symmetric_result.txt

# --- 4. CIFRADO Y DESCIFRADO HÍBRIDO ---
echo "
--- Paso 5: Probando '8. Cifrado Híbrido'... ---"
# Se simula la entrada: "8", el archivo a cifrar y la clave pública a usar.
echo -e "8\ntest_file.txt\nmy_test_keys_public.pem" | ./main.sh
# Se renombra el archivo cifrado para no confundirlo con el de la prueba simétrica
mv test_file.txt.enc hybrid_test_file.txt.enc
echo "Archivos 'hybrid_test_file.txt.enc' y 'aes_key.bin.enc' deberían haber sido creados."
ls hybrid_test_file.txt.enc aes_key.bin.enc

echo "
--- Paso 6: Probando '9. Descifrado Híbrido'... ---"
# Se simula la entrada: "9", el archivo cifrado y la clave privada para descifrar.
echo -e "9\nhybrid_test_file.txt.enc\nmy_test_keys_private.pem" | ./main.sh
mv decrypted_hybrid_test_file.txt.enc decrypted_hybrid_result.txt
echo "Archivo descifrado: 'decrypted_hybrid_result.txt'"
cat decrypted_hybrid_result.txt

# --- 5. VERIFICACIÓN FINAL ---
echo "
--- Paso 7: Verificando la integridad de los datos... ---"
# Compara el archivo original con los dos resultados descifrados.
# Si no hay salida, los archivos son idénticos.
if diff -q test_file.txt decrypted_symmetric_result.txt && diff -q test_file.txt decrypted_hybrid_result.txt; then
  echo "¡ÉXITO! Los archivos originales y los descifrados son idénticos."
else
  echo "¡FALLO! Los archivos descifrados no coinciden con el original."
  exit 1
fi

# --- 6. LIMPIEZA ---
echo "
--- Paso 8: Limpiando archivos de prueba... ---"
rm -f my_test_keys* test_file* key.bin* aes_key.bin* decrypted_* hybrid_test_file.txt.enc aes_key.bin.enc
echo "Limpieza completada."


echo "================================================="
echo "      PRUEBA FINALIZADA CON ÉXITO"
echo "================================================="
