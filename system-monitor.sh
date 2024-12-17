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

# Fonction pour lister les processus en cours
monitor_processes() {
    echo "$(date): Surveillance des processus" >> "$LOG_FILE"
    ps -eo user,pid,ppid,%mem,%cpu,comm --sort=-%mem,-%cpu >> "$LOG_FILE"
    ps -eo user,pid,ppid,%mem,%cpu,comm --sort=-%mem,-%cpu
    echo "Nombre total de processus actifs : $(ps -e | wc -l)"
}


if [[ $# -lt 1 ]]; then
    show_usage
    exit 1
fi

while getopts "hmcp" opt; do
    case $opt in
        h) HELP ;;
        m) monitor_memory ;;
        c) monitor_io ;;
        p) monitor_processes ;;
    esac
done

