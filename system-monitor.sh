#!/bin/bash


# Fonction pour afficher l'utilisation
show_usage() {
    echo "system-monitor: [-h|--help] [-T] [-t] [-n] [-N] [-d] [-m] [-s] chemin.."
}

if [[ $# -lt 1 ]]; then
    show_usage
    exit 1
fi
