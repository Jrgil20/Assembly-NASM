# Compilación y enlace de archivos de ensamblador NASM

```bash
nasm -f elf32 archivo.asm -o archivo.o
ld -m elf_i386 archivo.o -o ejecutable
```

En estos comandos:

- `nasm` es el ensamblador NASM.
- `-f elf32` especifica el formato de salida. En este caso, estamos generando un objeto de formato ELF 32-bit, que es común en sistemas Linux.
- `archivo.asm` es tu archivo de código fuente de ensamblador.
- `-o archivo.o` especifica el nombre del archivo de salida del ensamblador.
- `ld` es el enlazador que toma uno o más archivos de objeto y los enlaza para crear un ejecutable.
- `-m elf_i386` especifica el formato de enlace. En este caso, estamos enlazando para un formato ELF 32-bit.
- `ejecutable` es el nombre del archivo ejecutable final.

Por favor, reemplaza `archivo.asm` y `ejecutable` con los nombres de tus archivos

Para ejecutar el archivo binario que has creado, puedes usar el siguiente comando en la terminal:

./ejecutable
En este comando:

./ indica al sistema que busque el archivo en el directorio actual.
ejecutable es el nombre del archivo ejecutable que has creado.
Por favor, reemplaza ejecutable con el nombre de tu archivo ejecutable.