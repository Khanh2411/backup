#!/bin/bash

TIMESTAMP=$(date +%F-%H-%M)
BACKUP_FILE="/tmp/backup-$TIMESTAMP.sql"
S3_BUCKET="s3://bht-bookstore-images/bht-bookstore-backup/"

# Dump database
mysqldump -h bht-bookstore-db.cene4ioesbip.us-east-1.rds.amazonaws.com -u admin -pkhanhnguyen241104 bht_bookstore > $BACKUP_FILE 
# Upload to S3
aws s3 cp $BACKUP_FILE $S3_BUCKET/

# Clean up
rm $BACKUP_FILE
