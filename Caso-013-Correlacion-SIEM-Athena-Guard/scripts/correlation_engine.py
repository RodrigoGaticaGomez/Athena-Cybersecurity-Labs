#!/usr/bin/env python3

import json
from datetime import datetime
from pathlib import Path
from typing import Any


LOG_FILE = Path("logs/eventos_prueba.jsonl")
OUTPUT_FILE = Path("resultados/incidentes_detectados.json")

MIN_FAILED_LOGINS = 3
CORRELATION_WINDOW_SECONDS = 300


def cargar_eventos(ruta: Path) -> list[dict[str, Any]]:
    eventos: list[dict[str, Any]] = []

    try:
        with ruta.open("r", encoding="utf-8") as archivo:
            for numero_linea, linea in enumerate(archivo, start=1):
                linea = linea.strip()

                if not linea:
                    continue

                try:
                    evento = json.loads(linea)
                    evento["timestamp_dt"] = datetime.fromisoformat(
                        evento["timestamp"]
                    )
                    eventos.append(evento)

                except (json.JSONDecodeError, KeyError, ValueError) as error:
                    print(f"[ERROR] Línea {numero_linea}: {error}")

    except FileNotFoundError:
        print(f"[ERROR] No se encontró el archivo: {ruta}")

    return sorted(
        eventos,
        key=lambda evento: evento["timestamp_dt"]
    )


def correlacionar_eventos(
    eventos: list[dict[str, Any]]
) -> list[dict[str, Any]]:
    incidentes: list[dict[str, Any]] = []

    for evento_scan in eventos:
        if evento_scan.get("event_type") != "port_scan":
            continue

        origen = evento_scan.get("source_ip")
        destino = evento_scan.get("destination_ip")
        inicio = evento_scan["timestamp_dt"]

        eventos_relacionados = [
            evento
            for evento in eventos
            if evento.get("source_ip") == origen
            and evento.get("destination_ip") == destino
            and inicio <= evento["timestamp_dt"]
            and (
                evento["timestamp_dt"] - inicio
            ).total_seconds() <= CORRELATION_WINDOW_SECONDS
        ]

        intentos_fallidos = [
            evento
            for evento in eventos_relacionados
            if evento.get("event_type") == "ssh_failed_login"
        ]

        accesos_exitosos = [
            evento
            for evento in eventos_relacionados
            if evento.get("event_type") == "ssh_successful_login"
        ]

        if (
            len(intentos_fallidos) >= MIN_FAILED_LOGINS
            and accesos_exitosos
        ):
            acceso_exitoso = accesos_exitosos[0]

            incidente = {
                "incident_type": "possible_ssh_compromise",
                "severity": "critical",
                "source_ip": origen,
                "destination_ip": destino,
                "failed_login_count": len(intentos_fallidos),
                "successful_username": acceso_exitoso.get("username"),
                "start_time": evento_scan["timestamp"],
                "end_time": acceso_exitoso["timestamp"],
                "correlation_window_seconds": (
                    acceso_exitoso["timestamp_dt"] - inicio
                ).total_seconds(),
                "status": "detected",
            }

            incidentes.append(incidente)

    return incidentes


def mostrar_eventos(eventos: list[dict[str, Any]]) -> None:
    print("\n=== EVENTOS CARGADOS ===")
    print(f"Total: {len(eventos)}\n")

    for numero, evento in enumerate(eventos, start=1):
        print(
            f"{numero}. {evento['timestamp']} | "
            f"{evento['event_type']} | "
            f"{evento['source_ip']} -> "
            f"{evento['destination_ip']}"
        )


def mostrar_incidentes(
    incidentes: list[dict[str, Any]]
) -> None:
    print("\n=== RESULTADO DE CORRELACIÓN ===")

    if not incidentes:
        print("[INFO] No se detectaron incidentes correlacionados.")
        return

    for numero, incidente in enumerate(incidentes, start=1):
        print(f"\n[ALERTA CRÍTICA #{numero}]")
        print(f"Tipo: {incidente['incident_type']}")
        print(f"Severidad: {incidente['severity']}")
        print(f"IP origen: {incidente['source_ip']}")
        print(f"IP destino: {incidente['destination_ip']}")
        print(
            "Intentos SSH fallidos: "
            f"{incidente['failed_login_count']}"
        )
        print(
            "Usuario comprometido: "
            f"{incidente['successful_username']}"
        )
        print(f"Inicio: {incidente['start_time']}")
        print(f"Fin: {incidente['end_time']}")
        print(
            "Ventana temporal: "
            f"{incidente['correlation_window_seconds']} segundos"
        )



def guardar_incidentes(
    incidentes: list[dict[str, Any]],
    ruta_salida: Path
) -> None:
    ruta_salida.parent.mkdir(parents=True, exist_ok=True)

    with ruta_salida.open("w", encoding="utf-8") as archivo:
        json.dump(
            incidentes,
            archivo,
            indent=4,
            ensure_ascii=False
        )

    print(f"\n[OK] Incidentes guardados en: {ruta_salida}")


def main() -> None:
    eventos = cargar_eventos(LOG_FILE)

    print("=== ATHENA GUARD CORRELATION ENGINE ===")

    mostrar_eventos(eventos)

    incidentes = correlacionar_eventos(eventos)

    mostrar_incidentes(incidentes)

    guardar_incidentes(incidentes, OUTPUT_FILE)


if __name__ == "__main__":
    main()