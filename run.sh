#!/usr/bin/env bash
set -e

echo "[START] Lancement de l'environnement Ansible..."

# 1. Construire et démarrer les conteneurs
docker compose up -d --build

echo "[CHECK] Vérification de l'état des conteneurs..."
sleep 2

# 2. Vérifier que nhitec01, nhitec02 et nhitec03 sont bien "running"
REQUIRED_CONTAINERS=("nhitec01" "nhitec02" "nhitec03")
FAILED=0

for c in "${REQUIRED_CONTAINERS[@]}"; do
    STATUS=$(docker inspect -f '{{.State.Status}}' "$c" 2>/dev/null || echo "missing")
    if [ "$STATUS" != "running" ]; then
        echo "❌ $c n'est pas lancé (état: $STATUS)"
        FAILED=1
    else
        echo "✅ $c est en cours d'exécution"
    fi
done

if [ $FAILED -ne 0 ]; then
    echo "⚠️  Erreur : tous les conteneurs requis ne sont pas démarrés."
    docker compose ps
    exit 1
fi

# 3. Connexion au conteneur de contrôle nhitec03
echo "[CONNECT] Connexion au serveur de contrôle (nhitec03)..."
docker compose exec nhitec03 bash
