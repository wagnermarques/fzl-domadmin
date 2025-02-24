#!/bin/bash

THUNDERBIRD_PERFIL_DIR=~/.thunderbird/
BACKUP_LABEL=BK_EMAIL_THUNDERBIRD_WAGNERDESKTOP
BACKUP_DIR=/run/media/wagner/NSI-BACKUP/backups/emails/thunderbird/$BACKUP_LABEL/dotThunderbird
mkdir -p /run/media/wagner/NSI-BACKUP/backups/emails/thunderbird/$BACKUP_LABEL/dotThunderbird
rsync -va $THUNDERBIRD_PERFIL_DIR $BACKUP_DIR
