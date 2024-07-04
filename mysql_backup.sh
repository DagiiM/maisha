#!/bin/bash

# MySQL credentials
DB_NAME="maisha"
DB_USER="maisha"
DB_PASSWORD="maisha"
DB_HOST="localhost"  # Change if your database is hosted elsewhere

# Backup directory
BACKUP_DIR="maisha_backup"
DATE=$(date +%Y%m%d_%H%M%S)

# Filename for the backup
BACKUP_FILENAME="$DB_NAME_$DATE.sql"

# Command to perform the backup
mysqldump -u $DB_USER -p$DB_PASSWORD -h $DB_HOST $DB_NAME > $BACKUP_DIR/$BACKUP_FILENAME

# Check if the backup was successful
if [ $? -eq 0 ]; then
  echo "Backup successful: $BACKUP_DIR/$BACKUP_FILENAME"
else
  echo "Backup failed"
fi
