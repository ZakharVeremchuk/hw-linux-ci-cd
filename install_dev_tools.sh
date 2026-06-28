#!/bin/bash


echo "Installing Python (3.9+)"

# Variables
PYTHON_MAJOR=$(python3 -c 'import sys; print(sys.version_info.major)' 2>/dev/null || echo 0)
PYTHON_MINOR=$(python3 -c 'import sys; print(sys.version_info.minor)' 2>/dev/null || echo 0)

# Compare verisons
if [ "$PYTHON_MAJOR" -eq 3 -a "$PYTHON_MINOR" -ge 9 ] || [ "$PYTHON_MAJOR" -gt 3 ]; then
    echo "Python is already installed. Current version: $PYTHON_MAJOR.$PYTHON_MINOR (Satisfies requirement >= 3.9)"
else
    echo "Python is missing or older than 3.9. Installing..."
    
    sudo apt-get update -y -qq
    sudo apt-get install -y -qq software-properties-common
    sudo add-apt-repository -y ppa:deadsnakes/ppa
    sudo apt-get update -y -qq
    
    sudo apt-get install -y -qq python3.9 python3.9-dev python3-pip
    echo "Python 3.9 installed."
fi

echo -e "Installing Django"

# Check if Django is available in the system
if python3 -c "import django" &> /dev/null; then
    echo "Django is already installed in the system. Skipping."
else
    echo "Django not found. Installing via pip..."
    pip3 install --quiet django
    echo "Django has been successfully installed."
fi

echo -e "Check version of Django"
python3 -m django --version
