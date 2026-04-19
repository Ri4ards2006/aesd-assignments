#!/bin/sh
writefile=$1
writestr=$2

if [ $# -ne 2 ]; then
    echo "Error: Two arguments required: <file_path> <text_string>"
    exit 1
fi

# Erstellt den Pfad, falls er nicht existiert
mkdir -p "$(dirname "$writefile")"

# Schreibt den String in die Datei (überschreibt Vorhandenes)
echo "$writestr" > "$writefile"

if [ $? -ne 0 ]; then
    echo "Error: Could not create file $writefile"
    exit 1
fi
