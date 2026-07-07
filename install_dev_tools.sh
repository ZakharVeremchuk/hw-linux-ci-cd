#!/bin/bash
set -euo pipefail

sudo apt-get update -y

if ! command -v docker >/dev/null 2>&1; then
    echo "Docker not found. Installing..."
    curl -fsSL https://get.docker.com -o /tmp/get-docker.sh
    sudo sh /tmp/get-docker.sh
    rm -f /tmp/get-docker.sh
else
    echo "Docker installed: $(docker --version)"
fi

if ! docker compose version >/dev/null 2>&1; then
    echo "Docker Compose plugin not found. Installing..."
    sudo apt-get install -y docker-compose-plugin
else
    echo "Docker Compose already installed: $(docker compose version)"
fi

echo "Checking Python (3.9+)"

# choose python executable reliably
PYTHON_CMD=""
if command -v python3 >/dev/null 2>&1; then
    PYTHON_CMD=python3
elif command -v python3.9 >/dev/null 2>&1; then
    PYTHON_CMD=python3.9
fi

if [ -n "$PYTHON_CMD" ]; then
    PYTHON_MAJOR=$($PYTHON_CMD -c 'import sys; print(sys.version_info.major)' 2>/dev/null || echo 0)
    PYTHON_MINOR=$($PYTHON_CMD -c 'import sys; print(sys.version_info.minor)' 2>/dev/null || echo 0)
else
    PYTHON_MAJOR=0
    PYTHON_MINOR=0
fi

if [ "$PYTHON_MAJOR" -gt 3 ] || { [ "$PYTHON_MAJOR" -eq 3 ] && [ "$PYTHON_MINOR" -ge 9 ]; }; then
    echo "Python is already installed. Current version: $PYTHON_MAJOR.$PYTHON_MINOR (satisfies >= 3.9)"
else
    echo "Python is missing or older than 3.9. Installing..."
    sudo apt-get update -y -qq
    sudo apt-get install -y -qq software-properties-common
    sudo add-apt-repository -y ppa:deadsnakes/ppa
    sudo apt-get update -y -qq
    sudo apt-get install -y -qq python3.9 python3.9-dev python3.9-distutils python3-pip
    PYTHON_CMD=python3.9
    echo "Python 3.9 installed."
fi

echo "Installing Django"

# make sure pip is available for the chosen python
if ! $PYTHON_CMD -m pip --version >/dev/null 2>&1; then
    echo "pip not found for $PYTHON_CMD. Installing pip..."
    sudo apt-get install -y -qq python3-pip
fi

if $PYTHON_CMD -c "import django" >/dev/null 2>&1; then
    echo "Django is already installed in the system. Skipping."
else
    echo "Django not found. Installing via pip..."
    $PYTHON_CMD -m pip install --quiet django
    echo "Django has been successfully installed."
fi

echo "Check version of Django"
$PYTHON_CMD -m django --version || true
