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

# Fonction pour la surveillance des Entrées et Sorties des périphériques
monitor_io() {
    echo "$(date): Surveillance des E/S" >> "$LOG_FILE"
    iostat -x 5 3 >> "$LOG_FILE"
    iostat -x 5 3
}


if [[ $# -lt 1 ]]; then
    show_usage
    exit 1
fi

while getopts "hmc" opt; do
    case $opt in
        h) HELP ;;
        m) monitor_memory ;;
        c) monitor_io ;;
    esac
done

