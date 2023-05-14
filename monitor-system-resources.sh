#!/bin/bash

MEM_LIMIT=90
CPU_LIMIT=90
DISK_LIMIT=90

MEM_USAGE=$(free | awk "FNR == 2 {print $3/$2 * 100}")
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" |  sed "s/.*, *\([0-9]*\)%* id.*/\1/")
DISK_USAGE=$(df -h / | awk "(print $5)" | tail -1 | sed "s/%//")


