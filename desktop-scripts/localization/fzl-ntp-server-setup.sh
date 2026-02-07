#!/bin/bash

# fzl-ntp-server-setup.sh
# Configures systemd-timesyncd to use official Brazilian NTP servers (ntp.br)

set -e

BR_NTP_SERVERS="a.ntp.br b.ntp.br c.ntp.br d.ntp.br"

echo "🔍 Checking if systemd-timesyncd is available..."
if ! command -v timedatectl &> /dev/null; then
    echo "❌ 'timedatectl' not found. This script requires systemd."
    exit 1
fi

echo "🛑 Stopping systemd-timesyncd service..."
sudo systemctl stop systemd-timesyncd

# Backup only if the config file exists
if [ -f /etc/systemd/timesyncd.conf ]; then
    echo "✏️  Backing up existing timesyncd.conf..."
    sudo cp /etc/systemd/timesyncd.conf /etc/systemd/timesyncd.conf.bak
else
    echo "ℹ️  No existing timesyncd.conf found — skipping backup."
fi

echo "📝 Creating new timesyncd.conf with Brazilian NTP servers..."
sudo tee /etc/systemd/timesyncd.conf > /dev/null <<EOF
[Time]
NTP=$BR_NTP_SERVERS
FallbackNTP=0.pool.ntp.org 1.pool.ntp.org
RootDistanceMaxSec=5
PollIntervalMinSec=32
PollIntervalMaxSec=2048
EOF

echo "✅ Reloading systemd daemon..."
sudo systemctl daemon-reload

echo "🔄 Starting and enabling systemd-timesyncd..."
sudo systemctl enable --now systemd-timesyncd

echo "⏳ Waiting for time sync..."
sleep 6

echo "📋 Time sync status:"
timedatectl show-timesync --all | grep -E "(SystemClockSync|NTP|Server)"

echo -e "\n🎉 Brazilian NTP setup complete!"
echo "🌐 Servers: $BR_NTP_SERVERS"

sudo timedatectl set-timezone America/Sao_Paulo

sudo dnf install ntpdate -y

sudo ntpdate -q a.ntp.br
