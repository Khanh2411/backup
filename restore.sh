#!/bin/bash

S3_BUCKET="s3://bht-bookstore-images/bht-bookstore-backup/"
LATEST_FILE=$(aws s3 ls $S3_BUCKET/ | sort | tail -n 1 | awk '{print $4}')
DOWNLOAD_PATH="/tmp/$LATEST_FILE"

# Download from S3
aws s3 cp "$S3_BUCKET/$LATEST_FILE" $DOWNLOAD_PATH

# Restore to RDS
mysql -h bht-bookstore-db.cene4ioesbip.us-east-1.rds.amazonaws.com -u admin -pkhanhnguyen241104 bht_bookstore < $DOWNLOAD_PATH

# Clean up
rm $DOWNLOAD_PATH
