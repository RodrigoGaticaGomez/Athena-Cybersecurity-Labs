#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

readonly ATHENA_VERSION="0.2"
readonly CASO_ID="CASO-011"
readonly HOSTNAME_SYSTEM="$(hostname)"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CASO_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

readonly SCRIPT_DIR
readonly CASO_DIR

readonly LOG_DIR="${CASO_DIR}/logs"
readonly INCIDENTS_DIR="${CASO_DIR}/evidencias/incidentes"
readonly COUNTER_FILE="${LOG_DIR}/incident-counter.txt"
readonly EVENT_LOG="${LOG_DIR}/athena-guard-incidents.jsonl"

readonly COLOR_BLUE='\033[1;34m'
readonly COLOR_GREEN='\033[1;32m'
readonly COLOR_YELLOW='\033[1;33m'
readonly COLOR_RED='\033[1;31m'
readonly COLOR_RESET='\033[0m'

mostrar_banner() {
    printf '%b\n' "${COLOR_BLUE}"
    printf '%s\n' "============================================================"
    printf '%s\n' "                  ATHENA GUARD v${ATHENA_VERSION}"
    printf '%s\n' "        Respuesta Automatizada ante Incidentes"
    printf '%s\n' "============================================================"
    printf '%b\n' "${COLOR_RESET}"

    printf 'Caso: %s\n' "${CASO_ID}"
    printf 'Host: %s\n\n' "${HOSTNAME_SYSTEM}"
}

mostrar_uso() {
    printf 'Uso:\n'
    printf '  %s <ruta-del-archivo>\n\n' "$0"
}

crear_directorios() {
    mkdir -p "${LOG_DIR}" "${INCIDENTS_DIR}"
}

verificar_dependencias() {
    local dependencias=("jq" "sha256sum" "logger" "stat" "realpath")
    local dependencia

    for dependencia in "${dependencias[@]}"; do
        if ! command -v "${dependencia}" >/dev/null 2>&1; then
            printf '%b[ERROR]%b Falta la dependencia: %s\n' \
                "${COLOR_RED}" "${COLOR_RESET}" "${dependencia}"
            exit 1
        fi
    done

    printf '%b[OK]%b Dependencias verificadas.\n' \
        "${COLOR_GREEN}" "${COLOR_RESET}"
}

inicializar_contador() {
    if [[ ! -f "${COUNTER_FILE}" ]]; then
        printf '0\n' > "${COUNTER_FILE}"
    fi
}

generar_incident_id() {
    local contador

    contador="$(<"${COUNTER_FILE}")"

    if [[ ! "${contador}" =~ ^[0-9]+$ ]]; then
        printf '%b[ERROR]%b Contador inválido.\n' \
            "${COLOR_RED}" "${COLOR_RESET}"
        exit 1
    fi

    contador=$((contador + 1))
    printf '%s\n' "${contador}" > "${COUNTER_FILE}"

    printf 'ATH-INC-%04d\n' "${contador}"
}

clasificar_severidad() {
    local ruta="$1"

    case "${ruta}" in
        /etc/*|/usr/bin/*|/usr/sbin/*|/boot/*)
            printf 'CRITICAL\n'
            ;;
        */scripts/*|*/config/*|*/configuracion/*)
            printf 'HIGH\n'
            ;;
        */documentacion/*|*/README.md)
            printf 'MEDIUM\n'
            ;;
        *)
            printf 'LOW\n'
            ;;
    esac
}

crear_estructura_incidente() {
    local incident_id="$1"
    local incident_dir="${INCIDENTS_DIR}/${incident_id}"

    mkdir -p \
        "${incident_dir}/backup" \
        "${incident_dir}/metadata"

    printf '%s\n' "${incident_dir}"
}

validar_archivo() {
    local archivo="$1"

    if [[ ! -f "${archivo}" ]]; then
        printf '%b[ERROR]%b Archivo no válido: %s\n' \
            "${COLOR_RED}" "${COLOR_RESET}" "${archivo}"
        exit 1
    fi
}

main() {
    local archivo
    local archivo_absoluto
    local incident_id
    local incident_dir
    local severidad
    local hash_sha256
    local tamano
    local propietario
    local timestamp

    mostrar_banner
    crear_directorios
    verificar_dependencias
    inicializar_contador

    if [[ "$#" -ne 1 ]]; then
        mostrar_uso
        exit 1
    fi

    archivo="$1"
    validar_archivo "${archivo}"

    archivo_absoluto="$(realpath "${archivo}")"
    timestamp="$(date --iso-8601=seconds)"
    severidad="$(clasificar_severidad "${archivo_absoluto}")"
    hash_sha256="$(sha256sum "${archivo_absoluto}" | awk '{print $1}')"
    tamano="$(stat --format='%s' "${archivo_absoluto}")"
    propietario="$(stat --format='%U' "${archivo_absoluto}")"

    incident_id="$(generar_incident_id)"
    incident_dir="$(crear_estructura_incidente "${incident_id}")"

    printf '\n'
    printf '%b[INFO]%b Incidente: %s\n' \
        "${COLOR_YELLOW}" "${COLOR_RESET}" "${incident_id}"

    printf '%b[INFO]%b Archivo: %s\n' \
        "${COLOR_YELLOW}" "${COLOR_RESET}" "${archivo_absoluto}"

    printf '%b[INFO]%b Severidad: %s\n' \
        "${COLOR_YELLOW}" "${COLOR_RESET}" "${severidad}"

    printf '%b[INFO]%b SHA-256: %s\n' \
        "${COLOR_YELLOW}" "${COLOR_RESET}" "${hash_sha256}"

    printf '%b[INFO]%b Tamaño: %s bytes\n' \
        "${COLOR_YELLOW}" "${COLOR_RESET}" "${tamano}"

    printf '%b[INFO]%b Propietario: %s\n' \
        "${COLOR_YELLOW}" "${COLOR_RESET}" "${propietario}"

    printf '%b[INFO]%b Evidencias: %s\n' \
        "${COLOR_YELLOW}" "${COLOR_RESET}" "${incident_dir}"

    printf '%b[INFO]%b Fecha: %s\n' \
        "${COLOR_YELLOW}" "${COLOR_RESET}" "${timestamp}"

    printf '\n%b[OK]%b Archivo analizado correctamente.\n' \
        "${COLOR_GREEN}" "${COLOR_RESET}"
}

main "$@"
