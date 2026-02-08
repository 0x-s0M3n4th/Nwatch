# Nwatch - Network Throughput Logger

![License](https://img.shields.io/badge/license-MIT-blue.svg) ![Bash](https://img.shields.io/badge/language-Bash-green.svg) ![Platform](https://img.shields.io/badge/platform-Linux-lightgrey.svg)

## Overview
**Nwatch** is a specialized network throughput logging tool designed to analyze bandwidth usage and detect traffic anomalies on Linux systems. It automates the monitoring of network interfaces (like `eth0` or `wlan0`), logging incoming (RX) and outgoing (TX) traffic on an hourly basis and generating detailed daily reports.

This project was developed as a key component of a **Linux System Administration (RHCSA)** summer training program to demonstrate proficiency in system automation and network monitoring.

## Features
* **Multi-Interface Monitoring:** Capable of tracking one or more network interfaces simultaneously.
* **Granular Logging:** Records exact traffic data with timestamps every hour.
* **Automated Reporting:** Generates daily summaries of total entries and traffic flow.
* **Cron Integration:** Fully automated execution using `cron.hourly` and `crontab`.
* **Lightweight:** Built entirely with Bash and standard Linux tools, requiring minimal system resources.

## Tech Stack
* **Scripting Language:** Bash (Shell Scripting)
* **Network Tool:** `vnstat` (Traffic Monitor)
* **Automation:** `cron`, `systemd`
* **Text Processing:** `grep`, `cut`, `awk`

---

## Prerequisites
Before running Nwatch, ensure your system has `vnstat` installed and the service is active.

```bash
# Update repositories
sudo apt update

# Install vnstat
sudo apt install vnstat -y

# Start and enable the service
sudo systemctl start vnstat
sudo systemctl enable vnstat
```

## Installation & Setup

1. Clone the Repository:

```bash
git clone [https://github.com/0x-s0M3n4th/Nwatch.git](https://github.com/0x-s0M3n4th/Nwatch.git)
cd Nwatch
```
2. Configure System Directories:

```bash
sudo mkdir -p /var/log/netlog
sudo mkdir -p /var/log/netlogs/reports
# Set permissions (optional, adjust as needed)
sudo chmod -R 755 /var/log/netlog
```

3. Deploy scripts:

```bash
# Make scripts executable
chmod +x netlog_hourly.sh netlog_report.sh

# Move to bin directory
sudo cp netlog_hourly.sh /usr/local/bin/
sudo cp netlog_report.sh /usr/local/bin/
```

4. Setup Automation (Cron Jobs):

```bash
# enable hourly logging
sudo ln -s /usr/local/bin/netlog_hourly.sh /etc/cron.hourly/netlog_hourly

# enable daily reporting - open the crontab file:
sudo crontab -e

# add the following content:
0 23 * * * /usr/local/bin/netlog_report.sh

```

## Usage:

- View hourly logs:

```bash
cat /var/log/netlog/eth0_hourly.log
```

- View daily reports:

```bash
cat /var/log/netlogs/reports/eth0_report_YYYY-MM-DD.txt
```

- Mnaual testing:

```bash
sudo /usr/local/bin/netlog_hourly.sh
```


