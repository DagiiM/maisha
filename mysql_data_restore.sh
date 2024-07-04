#!/bin/bash

# MySQL credentials
DB_NAME="maisha"
DB_USER="maisha"
DB_PASSWORD="maisha"
DB_HOST="localhost"  # Change if your database is hosted elsewhere

# Backup directory
BACKUP_DIR="maisha_backup"

# Filename for the backup
BACKUP_FILENAME="20240408_064522.sql"

# Command to perform the restore
mysql -u $DB_USER -p$DB_PASSWORD -h $DB_HOST $DB_NAME < $BACKUP_DIR/$BACKUP_FILENAME

# Check if the backup was successful
if [ $? -eq 0 ]; then
  echo "Restore successful"
else
  echo "Restore failed"
fi
