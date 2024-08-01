#!/bin/bash

# Konfigurasi database
DB_USER="your_username"
DB_PASS="yourpassword"
DATABASES=("db1" "db2" "db3" "db4" "db5")

# Konfigurasi backup
BACKUP_DIR="/path/to/mysql_backup"
DROPBOX_DIR="/your/dropbox/folder"

# Buat direktori backup jika belum ada
mkdir -p $BACKUP_DIR

# Backup setiap database
for DB_NAME in "${DATABASES[@]}"; do
    BACKUP_FILE="$BACKUP_DIR/${DB_NAME}_$(date +%F).sql"
    mysqldump -u $DB_USER -p"$DB_PASS" $DB_NAME > $BACKUP_FILE

    if [ $? -eq 0 ]; then
        echo "Backup for $DB_NAME completed successfully."
    else
        echo "Error occurred during backup of $DB_NAME."
    fi
done

#Uploader Direktori
DROPBOX_UPLOADER="/path/to/Dropbox-Uploader/dropbox_uploader.sh"

# Upload semua file backup ke Dropbox
for file in $BACKUP_DIR/*; do
    $DROPBOX_UPLOADER upload $file $DROPBOX_DIR/

    if [ $? -eq 0 ]; then
        echo "Upload of $file to Dropbox completed successfully."
    else
        echo "Error occurred during upload of $file to Dropbox."
    fi
done

# Hapus backup lokal yang lebih dari 2 hari
find $BACKUP_DIR -type f -mtime +2 -exec rm {} \;

# Hapus file yang lebih dari 7 hari di Dropbox
$DROPBOX_UPLOADER list $DROPBOX_DIR/ | grep -E "\s[0-9]{4}-[0-9]{2}-[0-9]{2}.sql$" | while read -r line; do
    file_date=$(echo $line | awk '{print $NF}' | grep -oE "[0-9]{4}-[0-9]{2}-[0-9]{2}")
    file_path=$(echo $line | awk '{print $(NF-1)}')

    if [ ! -z "$file_date" ]; then
        file_timestamp=$(date -d $file_date +%s)
        current_timestamp=$(date +%s)
        let diff_days=($current_timestamp-$file_timestamp)/86400

        if [ $diff_days -gt 7 ]; then
            $DROPBOX_UPLOADER delete $file_path
            if [ $? -eq 0 ]; then
                echo "Deleted $file_path from Dropbox."
            else
                echo "Error occurred while deleting $file_path from Dropbox."
            fi
        fi
    fi
done

echo "Backup, upload, and cleanup process completed."