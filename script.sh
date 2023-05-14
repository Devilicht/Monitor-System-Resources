#!/bin/bash

MEM_LIMIT=70
CPU_LIMIT=70
DISK_LIMIT=70

while true
do
    MEM_USAGE=$(free | awk 'FNR == 2 {print $3/$2 * 100}')
    CPU_USAGE=$(top -bn1 | grep 'Cpu(s)' | sed 's/.*, *\([0-9.]*\)%* id.*/\1/')
    DISK_USAGE=$(df -h / | awk '{print $5}' | tail -1 | sed 's/%//')

    echo "$(date +%T) - Uso de memória: $MEM_USAGE%"
    echo "$(date +%T) - Uso de CPU: $CPU_USAGE%"
    echo "$(date +%T) - Uso de disco: $DISK_USAGE%"

    if (( $(echo "$MEM_USAGE > $MEM_LIMIT" | bc -l) )); then
        echo "$(date +%T) ALERTA: Uso de memória acima de $MEM_LIMIT% ($MEM_USAGE%)"
    fi

    if (( $(echo "$CPU_USAGE > $CPU_LIMIT" | bc -l) )); then
        echo "$(date +%T) ALERTA: Uso de CPU acima de $CPU_LIMIT% ($CPU_USAGE%)"
    fi

    if (( $(echo "$DISK_USAGE > $DISK_LIMIT" | bc -l) )); then
        echo "$(date +%T) ALERTA: Uso de disco acima de $DISK_LIMIT% ($DISK_USAGE%)"
    fi

    echo " "    
    sleep 10
done
