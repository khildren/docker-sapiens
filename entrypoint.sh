#!/usr/bin/env bash
set -e

echo "=== Sapiens Dedicated Server Entrypoint ==="

# Defaults
UDP_PORT="${UDP_PORT:-16161}"
PUBLIC_MODE="${PUBLIC_MODE:-true}"
BUGREPORT_OPTIN="${BUGREPORT_OPTIN:-true}"

ARGS=()

if [[ "$PUBLIC_MODE" == "true" ]]; then
  ARGS+=("-public")
  echo "Starting in PUBLIC mode"
else
  echo "Starting in PRIVATE/LAN mode"
fi

if [[ "$BUGREPORT_OPTIN" == "true" ]]; then
  ARGS+=("-y")
fi

ARGS+=("-port" "$UDP_PORT")

echo "Launch args: ${ARGS[*]}"
echo "========================================="

exec /app/SapiensDedicatedServer "${ARGS[@]}"
