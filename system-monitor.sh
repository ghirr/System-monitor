#!/bin/bash

HELP_FILE="help.txt"
LOG_FILE="/var/log/surveillance.log"
VERSION="Systhem monitor v1"
AUTHORS="crée par trinome : Yasser & Islem & Zaineb"

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

# Fonction pour afficher les messages du fichier de trace
list_logs() {
        tac "$LOG_FILE" | less
}

#Menu graphique avec YAD
graphical_menu() {
    yad --form --center --border=10 --window-icon="~/System-monitor/icons/icon.png" --title="System Monitor" \
    	--button="Mémoire!$HOME/System-monitor/icons/ram.png":1  \
    	--button="E/S IO!$HOME/System-monitor/icons/io.png":2  \
    	--button="Processus!$HOME/System-monitor/icons/processor.png":3 \
    	--button="Logs!$HOME/System-monitor/icons/log.png":4 \
    	--button="Aide!$HOME/System-monitor/icons/help.png":5 \
    	--button="Github!$HOME/System-monitor/icons/github.png":6 \
    	--button="exit!$HOME/System-monitor/icons/exit.png":0 
    case $? in
        1) monitor_memory ;;
        2) monitor_io ;;
        3) monitor_processes ;;
        4) list_logs ;;
        5) HELP ;;
        6) yad --html --browser --uri=https://github.com/ghirr/System-monitor --width=650 --height=480 ;;
        0) exit 0 ;;
    esac
}

# Fonction pour afficher la version et les auteurs
show_version() {
    echo "$VERSION"
    echo "$AUTHORS"
}

# Menu textuel
menu_textuel() {
PS3="Votre choix : "  

select option in "HELP" "Monitor Memory" "Monitor IO" "Monitor Processes" "List Logs" "Show Version" "Graphical Menu" "Quitter"
do
    case $REPLY in
        1)  # Option 1 : HELP
            echo "Affichage de l'aide..."
            HELP   # Appel à la fonction HELP
            ;;
        2)  # Option 2 : Monitor Memory
            echo "Surveillance de la mémoire..."
            monitor_memory  # Appel à la fonction correspondante
            ;;
        3)  # Option 3 : Monitor IO
            echo "Surveillance des E/S..."
            monitor_io
            ;;
        4)  # Option 4 : Monitor Processes
            echo "Surveillance des processus..."
            monitor_processes
            ;;
        5)  # Option 5 : List Logs
            echo "Affichage des logs..."
            list_logs
            ;;
        6)  # Option 6 : Show Version
            echo "Affichage de la version..."
            show_version
            ;;
        7)  # Option 7 : Graphical Menu
            echo "Ouverture du menu graphique..."
            graphical_menu
            ;;
        8)  # Option 8 : Quitter
            echo "Fin du script. Au revoir !"
            exit 0
            ;;
        *)  # Choix incorrect
            show_usage
            ;;
    esac
done

} 

if [[ $# -lt 1 ]]; then
    show_usage
    exit 1
fi

while getopts "hmcpigvt" opt; do
    case $opt in
        h) HELP ;;
        m) monitor_memory ;;
        c) monitor_io ;;
        p) monitor_processes ;;
        i) list_logs ;;
        g) graphical_menu ;;
        v) show_version ;;
        t) menu_textuel ;;
    esac
done

