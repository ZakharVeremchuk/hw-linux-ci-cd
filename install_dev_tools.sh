#!/bin/bash

sudo apt-get update -y

if ! command -v docker &> /dev/null; then
    echo "Docker not found. Installing..."
    curl -fsSL https://get.docker.com -o get-docker.sh && sudo sh get-docker.sh
else
    echo "Docker installed: $(docker --version)"
fi

if ! docker compose version &> /dev/null; then
    echo "Docker Compose not found. Installing..."
    sudo apt-get install -y docker-compose-plugin
else
    echo "Docker Compose already installed: $(docker compose version)"
fi

if ! command -v python3 &> /dev/null; then
    echo "Python3 not found. Installing..."
    sudo apt-get install -y python3 python3-pip python3-venv
else
    echo "Python3 already installed: $(python3 --version)"
fi

mkdir -p my_django_project && cd my_django_project

if [ ! -d "venv" ]; then
    echo "Creating environment variable venv..."
    python3 -m venv venv
fi

source venv/bin/activate

pip install --upgrade pip
pip install django

echo "Finish"
