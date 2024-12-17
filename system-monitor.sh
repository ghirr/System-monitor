#!/bin/bash

HELP_FILE="help.txt"
LOG_FILE="/var/log/surveillance.log"

# Fonction pour afficher l'utilisation
show_usage() {
    echo "system-monitor: [-h|--help] [-T] [-t] [-n] [-N] [-d] [-m] [-s] chemin.."
}

# Fonction pour afficher l'aide à partir de fichier help.txt
HELP() {
    cat "$HELP_FILE"
}

# Fonction pour la surveillance de la mémoire et du swap
monitor_memory() {
    echo "$(date): Surveillance de la mémoire" >> "$LOG_FILE"
    free -h >> "$LOG_FILE"
    free -h
}

if [[ $# -lt 1 ]]; then
    show_usage
    exit 1
fi

while getopts "hm" opt; do
    case $opt in
        h) HELP ;;
        m) monitor_memory ;;
    esac
done
