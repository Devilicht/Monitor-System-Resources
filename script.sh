#!/bin/bash

MEM_LIMIT=30
CPU_LIMIT=30
DISK_LIMIT=30

MEM_USAGE=$(free | awk 'FNR == 2 {print $3/$2 * 100}')
CPU_USAGE=$(top -bn1 | grep 'Cpu(s)' |  sed 's/.*, *\([0-9]*\)%* id.*/\1/')
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

if (($( echo "$MEM_USAGE" > "$MEM_LIMIT" | bc -l ) )); then
    echo "ALERTA: the memory is being used above the limit $MEM_LIMIT%"
fi

if (($( echo "$CPU_USAGE" > "$CPU_LIMIT" | bc -l ) )); then
    echo "ALERTA: the CPU is being used above the limit $CPU_LIMIT%"
fi

if (($( echo "$DISK_USAGE" > "$DISK_LIMIT" | bc -l ) )); then
    echo "ALERTA: the disk is being used above the limit $DISK_LIMIT%"
fi