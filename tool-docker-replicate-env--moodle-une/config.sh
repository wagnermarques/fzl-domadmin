#!/bin/bash
# Configuration file for Moodle Replication Scripts
# Edit these variables according to your environment

# ============================================
# DOCKER CONTAINERS
# ============================================
MOODLE_CONTAINER="moodle-unesp"
MYSQL_CONTAINER="edutec2-edutec2rodrr"
REDIS_CONTAINER="redis-master"

# ============================================
# DATABASE CONFIGURATION
# ============================================
MYSQL_USER="root"
MYSQL_PASSWORD=""  # IMPORTANT: Set your MySQL root password here
MYSQL_DATABASE=""  # IMPORTANT: Set your Moodle database name here
MYSQL_HOST="localhost"
MYSQL_PORT="3306"

# ============================================
# BACKUP CONFIGURATION
# ============================================
BACKUP_BASE_DIR="$HOME/moodle-backups"
BACKUP_RETENTION_DAYS=30  # Keep backups for 30 days

# ============================================
# MOODLE PATHS (inside container)
# ============================================
MOODLE_DATA_PATH="/var/www/html/moodledata"
MOODLE_CONFIG_PATH="/var/www/html/config.php"

# ============================================
# DOCKER COMPOSE (optional)
# ============================================
DOCKER_COMPOSE_FILE="$HOME/projs/projeto-moodle-unesp/moodle-unesp/docker-compose.yml"

# ============================================
# COLORS FOR OUTPUT
# ============================================
COLOR_RESET="\033[0m"
COLOR_GREEN="\033[0;32m"
COLOR_YELLOW="\033[0;33m"
COLOR_RED="\033[0;31m"
COLOR_BLUE="\033[0;34m"

# ============================================
# LOGGING
# ============================================
LOG_DIR="$HOME/moodle-backups/logs"
LOG_FILE="$LOG_DIR/moodle_replication_$(date +%Y%m%d).log"

# Create necessary directories
mkdir -p "$BACKUP_BASE_DIR"
mkdir -p "$LOG_DIR"
