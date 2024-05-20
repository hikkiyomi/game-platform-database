#!/bin/bash

(
	crontab -l 2>/dev/null
	echo "0 0-23/$BACKUP_FREQUENCY * * * ./backup.sh"
) | crontab
