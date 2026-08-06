#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CASO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
LOG="${1:-$CASO_DIR/evidencias/04_logs_nginx/nginx_completo.log}"

if [[ ! -f "$LOG" ]]; then
  echo "ERROR: no existe el archivo de logs: $LOG" >&2
  exit 1
fi

echo "CASO-005 — DETECCIÓN AUTOMÁTICA DE ATAQUES WEB"
echo "Fuente: $LOG"
echo "Fecha: $(date --iso-8601=seconds)"
echo

echo "=== ALERTA 1: RECONOCIMIENTO AUTOMATIZADO ==="
jq -Rr '
  fromjson?
  | select(.http_user_agent == "Athena-Labs-Recon/1.0")
  | "[RECON] \(.timestamp) | \(.remote_addr) | HTTP \(.status) | \(.request_uri)"
' "$LOG"

echo
echo "=== ALERTA 2: INDICADORES DE ATAQUE EN URI ==="
jq -Rr '
  fromjson?
  | select(
      (.request_uri | ascii_downcase)
      | test("%27.*or|%3cscript|/\\.env|/\\.git|wp-login|phpmyadmin|backup\\.zip")
    )
  | "[WEB-ATTACK] \(.timestamp) | \(.remote_addr) | HTTP \(.status) | \(.request_uri)"
' "$LOG"

echo
echo "=== ALERTA 3: ACCESO A RECURSO PROTEGIDO ==="
jq -Rr '
  fromjson?
  | select(.status == 403)
  | "[FORBIDDEN] \(.timestamp) | \(.remote_addr) | \(.request_uri)"
' "$LOG"

echo
echo "=== ALERTA 4: SOLICITUD HTTP MALFORMADA ==="
jq -Rr '
  fromjson?
  | select(.status == 400 and .request_uri == "")
  | "[MALFORMED] \(.timestamp) | \(.remote_addr) | HTTP 400 | posible traversal"
' "$LOG"

echo
echo "=== RESUMEN POR IP Y ESTADO HTTP ==="
jq -Rr '
  fromjson?
  | select(.remote_addr != null)
  | "\(.remote_addr) \(.status)"
' "$LOG" |
  sort |
  uniq -c |
  awk '{printf "%s | HTTP %s | %s eventos\n", $2, $3, $1}'
