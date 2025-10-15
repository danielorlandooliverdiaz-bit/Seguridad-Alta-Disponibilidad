# Aplicación de Cifrado con OpenSSL

Esta es una aplicación de línea de comandos que utiliza OpenSSL para realizar diversas operaciones de cifrado, incluyendo la generación de claves, el cifrado y descifrado simétrico y asimétrico (híbrido).

## Características

*   **Generación de Claves RSA:** Genere un par de claves pública y privada RSA de 2048 bits.
*   **Cifrado y Descifrado Simétrico:** Cifre y descifre archivos utilizando AES-256-CBC con una clave generada aleatoriamente.
*   **Cifrado y Descifrado Híbrido:** Combine el cifrado simétrico y asimétrico para un cifrado seguro y eficiente. El archivo se cifra con una clave AES aleatoria, y esta clave AES se cifra con una clave pública RSA.
*   **Gestión de Claves:**
    *   Visualice los detalles de una clave pública.
    *   Busque claves públicas en un directorio.
    *   Importe claves públicas a un "llavero" (directorio `keyring`).
    *   Exporte claves públicas desde el "llavero".

## Requisitos

*   [OpenSSL](https://www.openssl.org/)

## Instalación

1.  Clone el repositorio o descargue el script `app.sh`.
2.  Asegúrese de que el script tenga permisos de ejecución:
    ```bash
    chmod +x app.sh
    ```

## Uso

Para iniciar la aplicación, ejecute el siguiente comando en su terminal:

```bash
./app.sh
```

Aparecerá un menú con las siguientes opciones:

--- Menú de Operaciones OpenSSL ---
1. Generar claves RSA
2. Cifrado simétrico
3. Descifrado simétrico
4. Cifrado híbrido
5. Descifrado híbrido
6. Visualizar clave pública
7. Buscar claves públicas
8. Importar clave pública
9. Exportar clave pública
0. Salir
-----------------------------------

Seleccione una opción e ingrese la información solicitada (por ejemplo, rutas de archivos, nombres de claves).

### Descripción de las Opciones

*   **1. Generar claves RSA:**
    *   Le pide una ruta para guardar las claves.
    *   Genera una clave privada (`*_private.pem`) y una clave pública (`*_public.pem`).

*   **2. Cifrado simétrico:**
    *   Le pide la ruta del archivo a cifrar.
    *   Genera una clave simétrica (`key.bin`).
    *   Cifra el archivo y lo guarda con la extensión `.enc`.

*   **3. Descifrado simétrico:**
    *   Le pide la ruta del archivo a descifrar (con la extensión `.enc`).
    *   Utiliza el archivo `key.bin` para descifrar el contenido.
    *   Guarda el archivo descifrado sin la extensión `.enc`.

*   **4. Cifrado híbrido:**
    *   Le pide la ruta del archivo a cifrar y la ruta de la clave pública RSA del destinatario.
    *   Cifra el archivo con una clave AES de sesión (`aes_key.bin`).
    *   Cifra la clave de sesión con la clave pública RSA y la guarda como `aes_key.bin.enc`.

*   **5. Descifrado híbrido:**
    *   Le pide la ruta del archivo cifrado y la ruta de su clave privada RSA.
    *   Descifra la clave de sesión (`aes_key.bin.enc`) utilizando su clave privada.
    *   Descifra el archivo utilizando la clave de sesión.

*   **6. Visualizar clave pública:**
    *   Muestra los detalles de un archivo de clave pública.

*   **7. Buscar claves públicas:**
    *   Busca archivos de clave pública (`.pem`, `.pub`) en un directorio específico.

*   **8. Importar clave pública:**
    *   Copia un archivo de clave pública a un directorio `keyring` local para un fácil acceso.

*   **9. Exportar clave pública:**
    *   Copia una clave pública desde el `keyring` a una ubicación especificada.

*   **0. Salir:**
    *   Termina la ejecución del script.

## Descargo de Responsabilidad

Esta herramienta está destinada a fines educativos y de demostración. Asegúrese de gestionar sus claves privadas de forma segura y de no compartirlas nunca. La seguridad de sus datos cifrados depende de la seguridad de sus claves.