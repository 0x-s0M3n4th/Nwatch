#!/bin/bash
cat << "EOF"

███╗   ██╗██╗    ██╗ █████╗ ████████╗ ██████╗██╗  ██╗
████╗  ██║██║    ██║██╔══██╗╚══██╔══╝██╔════╝██║  ██║
██╔██╗ ██║██║ █╗ ██║███████║   ██║   ██║     ███████║
██║╚██╗██║██║███╗██║██╔══██║   ██║   ██║     ██╔══██║
██║ ╚████║╚███╔███╔╝██║  ██║   ██║   ╚██████╗██║  ██║
╚═╝  ╚═══╝ ╚══╝╚══╝ ╚═╝  ╚═╝   ╚═╝    ╚═════╝╚═╝  ╚═╝
                                                     
EOF
echo "Welcome to Nwatch - Our specialized network throughput logger!"
LOG_DIR="/var/log/netlog"
INTERFACES=("eth0" "wlan0")  # Change as needed
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

mkdir -p "$LOG_DIR"

for IFACE in "${INTERFACES[@]}"; do
    # Collect stats
    STATS=$(vnstat -i "$IFACE" --oneline | cut -d';' -f3,4,5,6)

    RX=$(echo "$STATS" | cut -d';' -f1)
    RX_UNIT=$(echo "$STATS" | cut -d';' -f2)
    TX=$(echo "$STATS" | cut -d';' -f3)
    TX_UNIT=$(echo "$STATS" | cut -d';' -f4)

    LOG_FILE="${LOG_DIR}/${IFACE}_hourly.log"
    echo "$TIMESTAMP | IN: $RX $RX_UNIT | OUT: $TX $TX_UNIT" >> "$LOG_FILE"
done