#!/bin/bash

# Lista todos los archivos y carpetas no rastreados
untracked_files=$(git ls-files --others --exclude-standard)

# Agrega las carpetas principales y archivos sueltos al .gitignore
for item in $untracked_files; do
  # Si el ítem contiene una barra, es un directorio, de lo contrario es un archivo
  if [[ $item == */* ]]; then
    echo "${item%%/*}/" >>.gitignore
  else
    echo "$item" >>.gitignore
  fi
done

# Elimina duplicados en .gitignore
sort -u -o .gitignore .gitignore
