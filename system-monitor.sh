#!/bin/bash

HELP_FILE="help.txt"

# Fonction pour afficher l'utilisation
show_usage() {
    echo "system-monitor: [-h|--help] [-T] [-t] [-n] [-N] [-d] [-m] [-s] chemin.."
}

# Fonction pour afficher l'aide à partir de fichier help.txt
HELP() {
    cat "$HELP_FILE"
}

if [[ $# -lt 1 ]]; then
    show_usage
    exit 1
fi
