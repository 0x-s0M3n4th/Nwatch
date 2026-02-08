#!/bin/bash

LOG_DIR="/var/log/netlogs"
REPORT_DIR="/var/log/netlogs/reports"
TODAY=$(date '+%Y-%m-%d')
mkdir -p "$REPORT_DIR"

for LOG in "$LOG_DIR"/*_hourly.log; do
    IFACE=$(basename "$LOG" | cut -d'_' -f1)
    REPORT_FILE="${REPORT_DIR}/${IFACE}_report_${TODAY}.txt"

    echo "Report for $IFACE on $TODAY" > "$REPORT_FILE"
    echo "=====================================" >> "$REPORT_FILE"
    grep "$TODAY" "$LOG" >> "$REPORT_FILE"
    echo -e "\nTotal Entries: $(grep "$TODAY" "$LOG" | wc -l)" >> "$REPORT_FILE"
done