#!/usr/bin/env bash
set -e
echo "[STOP] Arrêt de l'environnement Ansible..."
docker compose down -v
echo "[DONE] Environnement arrêté."