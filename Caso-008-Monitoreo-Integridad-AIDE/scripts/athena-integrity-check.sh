#!/usr/bin/env bash

set -u

CONFIG="/home/rodrigo/Documentos/Athena-Cybersecurity-Labs/Caso-008-Monitoreo-Integridad-AIDE/laboratorio/aide-athena.conf"
REPORT_DIR="/home/rodrigo/Documentos/Athena-Cybersecurity-Labs/Caso-008-Monitoreo-Integridad-AIDE/evidencias/05_deteccion"
TIMESTAMP="$(date +%Y%m%d_%H%M%S)"
TMP_REPORT="/tmp/athena_guard_${TIMESTAMP}.txt"
FINAL_REPORT="${REPORT_DIR}/athena_guard_${TIMESTAMP}.txt"

echo "================================================="
echo "              ATHENA GUARD v0.1"
echo "================================================="
echo
echo "Fecha: $(date)"
echo "Host: $(hostname)"
echo
echo "Verificando integridad de Athena Labs..."
echo

sudo aide --check --config="$CONFIG" 2>&1 | tee "$TMP_REPORT"
AIDE_STATUS=${PIPESTATUS[0]}

cp "$TMP_REPORT" "$FINAL_REPORT"

echo
echo "-------------------------------------------------"

if [ "$AIDE_STATUS" -eq 0 ]; then
    echo "ESTADO: INTEGRIDAD VERIFICADA"
    echo "No se detectaron modificaciones."
else
    echo "ESTADO: CAMBIOS DETECTADOS"
    echo "Revisar reporte:"
    echo "$FINAL_REPORT"
fi

echo "-------------------------------------------------"

exit "$AIDE_STATUS"
