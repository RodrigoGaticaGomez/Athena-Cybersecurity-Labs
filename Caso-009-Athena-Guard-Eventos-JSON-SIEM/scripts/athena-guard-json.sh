#!/usr/bin/env bash

set -uo pipefail

CASO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LOG_DIR="$CASO_DIR/logs"
LOG_JSON="$LOG_DIR/athena-guard-events.jsonl"
AIDE_CONFIG="$CASO_DIR/../Caso-008-Monitoreo-Integridad-AIDE/laboratorio/aide-athena.conf"

mkdir -p "$LOG_DIR"

timestamp="$(date --iso-8601=seconds)"
host="$(hostname)"

emitir_evento() {
    jq -cn \
        --arg timestamp "$timestamp" \
        --arg host "$host" \
        --arg severity "$1" \
        --arg event "$2" \
        --arg path "$3" \
        --arg description "$4" \
        '{
            timestamp: $timestamp,
            host: $host,
            tool: "AIDE",
            source: "athena-guard",
            severity: $severity,
            event: $event,
            path: $path,
            description: $description
        }' >> "$LOG_JSON"
}

echo "========================================"
echo "        ATHENA GUARD JSON v1.0"
echo "========================================"
echo "Fecha: $timestamp"
echo "Host:  $host"
echo

if [[ ! -f "$AIDE_CONFIG" ]]; then
    echo "[ERROR] No existe $AIDE_CONFIG"

    emitir_evento \
        "critical" \
        "configuration_missing" \
        "$AIDE_CONFIG" \
        "No se encontró la configuración de AIDE"

    exit 1
fi

echo "Ejecutando verificación de integridad..."

aide_output="$(sudo aide --config="$AIDE_CONFIG" --check 2>&1)"
aide_status=$?

printf '%s\n' "$aide_output"

if grep -q "AIDE found NO differences" <<< "$aide_output"; then
    emitir_evento \
        "informational" \
        "integrity_check_clean" \
        "$CASO_DIR" \
        "AIDE no detectó cambios"

    echo
    echo "[OK] Integridad verificada."
else
    emitir_evento \
        "high" \
        "integrity_changes_detected" \
        "$CASO_DIR" \
        "AIDE detectó cambios de integridad"

    echo
    echo "[ALERTA] AIDE detectó cambios."
fi

echo
echo "Log JSON:"
echo "$LOG_JSON"

exit "$aide_status"
