#!/bin/bash

# Configuración
LOCALE="es_AR.UTF-8"
export LANG=$LOCALE

# Obtener fecha actual
current_date=$(date "+%A %d de %B de %Y")
current_time=$(date "+%H:%M:%S")

# Generar calendario con formato mejorado
calendar=$(cal -3 |
  sed 's/^/  /' |
  sed 's/[Sa]/<span color=\"#ff6699\">&<\/span>/' |
  sed 's/[Do]/<span color=\"#ffcc66\">&<\/span>/')

# Formato JSON
cat <<EOF
{
    "text": "$(date +%H:%M)",
    "tooltip": "<big>$current_date</big>\nHora: <b>$current_time</b>\n\n<tt>$calendar</tt>",
    "alt": "$(date +%a)",
    "class": "clock"
}
EOF
