# Aplicación de Cifrado con OpenSSL

Esta es una aplicación de línea de comandos que utiliza OpenSSL para realizar diversas operaciones de cifrado, incluyendo la generación de claves, el cifrado y descifrado simétrico y asimétrico (híbrido).

## Características

*   **Generación de Claves RSA:** Genere un par de claves pública y privada RSA de 2048 bits.
*   **Gestión de Claves:**
    *   Busque claves públicas en un directorio.
    *   Importe claves públicas a un "llavero" (directorio `keyring`) para un fácil acceso.
    *   Exporte claves públicas desde el "llavero".
    *   Visualice los detalles de una clave pública.
*   **Cifrado y Descifrado Simétrico:** Cifre y descifre archivos utilizando AES-256-CBC con una clave generada aleatoriamente.
*   **Cifrado y Descifrado Híbrido:** Combine el cifrado simétrico y asimétrico para un cifrado seguro y eficiente. El archivo se cifra con una clave AES aleatoria, y esta clave AES se cifra con una clave pública RSA.

## Requisitos

*   [OpenSSL](https://www.openssl.org/)

## Instalación

1.  Clone el repositorio o descargue los archivos del proyecto.
2.  Asegúrese de que todos los scripts `.sh` tengan permisos de ejecución:
    ```bash
    chmod +x main.sh scripts/*.sh
    ```

## Pruebas

Para verificar rápidamente que la aplicación funciona correctamente en su sistema, puede utilizar el script de prueba automatizado.

1.  Primero, asegúrese de que el script de prueba tenga permisos de ejecución:
    ```bash
    chmod +x run_tests.sh
    ```

2.  Luego, ejecútelo:
    ```bash
    ./run_tests.sh
    ```

Este script simulará los pasos para generar claves, cifrar un archivo de prueba con el método simétrico e híbrido, y luego descifrarlos, verificando que el contenido final sea idéntico al original. Al final, limpiará todos los archivos generados.

## Uso

Para iniciar la aplicación, ejecute el siguiente comando en su terminal:

```bash
./main.sh
```

Aparecerá un menú con las siguientes opciones:

--- Menú de Operaciones OpenSSL ---
1.  Generar un par de claves (pública/privada)
2.  Buscar claves públicas disponibles
3.  Importar clave pública
4.  Exportar clave pública
5.  Ver contenido de una clave pública
----------------------------------------
6.  Cifrado Simétrico
7.  Descifrado Simétrico
----------------------------------------
8.  Cifrado Híbrido
9.  Descifrado Híbrido
----------------------------------------
10. Salir
========================================

Seleccione una opción e ingrese la información solicitada.

### Descripción de las Opciones

A continuación se detallan las operaciones que puede realizar:

#### Gestión de Claves

*   **1. Generar un par de claves (pública/privada):**
    *   Esta opción crea un par de claves RSA de 2048 bits.
    *   Se le pedirá un nombre para las claves. Por ejemplo, si introduce `mi_clave`, se crearán dos archivos: `mi_clave_private.pem` (su clave privada) y `mi_clave_public.pem` (su clave pública).
    *   **¡Guarde su clave privada en un lugar seguro y nunca la comparta!**

*   **2. Buscar claves públicas disponibles:**
    *   Busca archivos de clave pública (`.pem`, `.pub`) en un directorio que usted especifique. Esto es útil para encontrar la clave de alguien a quien desea enviar un archivo cifrado.

*   **3. Importar clave pública:**
    *   Copia una clave pública de otra ubicación a su `keyring` (un directorio local para almacenar las claves públicas de otras personas).
    *   Esto facilita el acceso a las claves que usa con frecuencia.

*   **4. Exportar clave pública:**
    *   Copia una clave pública desde su `keyring` a otra ubicación. Útil para compartir su clave pública con otros.

*   **5. Ver contenido de una clave pública:**
    *   Muestra los detalles de un archivo de clave pública en formato de texto.

#### Cifrado y Descifrado

*   **6. Cifrado Simétrico:**
    *   Cifra un archivo usando una única clave secreta (cifrado AES-256-CBC).
    *   Se le pedirá la ruta del archivo a cifrar.
    *   El script generará una clave simétrica (`key.bin`) y cifrará su archivo, guardándolo con la extensión `.enc`.
    *   **Deberá enviar tanto el archivo `.enc` como el archivo `key.bin` al destinatario para que pueda descifrarlo.**

*   **7. Descifrado Simétrico:**
    *   Descifra un archivo que fue cifrado simétricamente.
    *   Necesitará el archivo cifrado (p. ej., `archivo.txt.enc`) y la clave simétrica (`key.bin`) en el mismo directorio.

*   **8. Cifrado Híbrido:**
    *   Este es el método **recomendado para enviar archivos a otros**. Combina la velocidad del cifrado simétrico con la seguridad del cifrado asimétrico.
    *   **Cómo funciona:**
        1.  Se genera una clave simétrica de un solo uso (`aes_key.bin`).
        2.  Su archivo se cifra con esta clave simétrica.
        3.  La clave simétrica (que es pequeña) se cifra con la **clave pública del destinatario**.
    *   **Resultado:** Obtendrá dos archivos para enviar: el archivo cifrado (`.enc`) y la clave de sesión cifrada (`aes_key.bin.enc`). El destinatario necesitará su clave privada para descifrar la clave de sesión y luego descifrar el archivo.

*   **9. Descifrado Híbrido:**
    *   Descifra un archivo recibido que fue cifrado con el método híbrido.
    *   Necesitará:
        1.  El archivo cifrado (p. ej., `documento.txt.enc`).
        2.  La clave de sesión cifrada (p. ej., `aes_key.bin.enc`).
        3.  **Su clave privada** correspondiente a la clave pública que se usó para cifrar.

*   **10. Salir:**
    *   Termina la ejecución del script.

## Descargo de Responsabilidad

Esta herramienta está destinada a fines educativos y de demostración. Asegúrese de gestionar sus claves privadas de forma segura y de no compartirlas nunca. La seguridad de sus datos cifrados depende de la seguridad de sus claves.
