#!/bin/bash

# --- RESTORE SCRIPT CONFIGURATION ---
S3_BUCKET="cicd-backup1/report/"
DOCKER_VOLUME_NAME="jenkins-data"
CONTAINER_VOLUME_PATH="/var/jenkins_home"
TEMP_DOWNLOAD_DIR="/tmp/jenkins_restore" # Temporary directory to download the backup
JENKINS_CONTAINER_NAME="jenkins"        # Your Jenkins container name (adjust if different)
# ------------------------------------

# Function to safely exit on error
function check_error {
    if [ $? -ne 0 ]; then
        echo "!! FATAL ERROR: $1"
        echo "Exiting restoration process."
        exit 1
    fi
}

# --- 1. DETERMINE WHICH BACKUP FILE TO USE ---
echo "--- 1. Listing available backups in s3://${S3_BUCKET}/ ---"
# List backups and sort them by date (latest first)
LATEST_BACKUP_FILE=$(aws s3 ls s3://${S3_BUCKET}/ \
    | awk '{print $4}' \
    | grep "^${DOCKER_VOLUME_NAME}_.*\.tar\.gz$" \
    | sort -r \
    | head -n 1)

if [ -z "$LATEST_BACKUP_FILE" ]; then
    echo "!! ERROR: Could not find any backup files for volume '${DOCKER_VOLUME_NAME}' in s3://${S3_BUCKET}/."
    exit 1
fi

# Ask the user which file to restore
echo ""
echo "The latest backup file found is: ${LATEST_BACKUP_FILE}"
read -p "Enter the backup filename to restore (or press ENTER to use the latest): " RESTORE_FILE_NAME

if [ -z "$RESTORE_FILE_NAME" ]; then
    RESTORE_FILE_NAME="$LATEST_BACKUP_FILE"
fi

echo "--- Preparing to restore using file: ${RESTORE_FILE_NAME} ---"


# --- 2. PREPARE ENVIRONMENT ---
echo "--- 2. Creating temporary download directory: ${TEMP_DOWNLOAD_DIR} ---"
mkdir -p "$TEMP_DOWNLOAD_DIR"
check_error "Failed to create temporary directory."


# --- 3. DOWNLOAD BACKUP FILE FROM S3 ---
S3_PATH="s3://${S3_BUCKET}/${RESTORE_FILE_NAME}"
LOCAL_PATH="${TEMP_DOWNLOAD_DIR}/${RESTORE_FILE_NAME}"

echo "--- 3. Downloading ${S3_PATH} to ${LOCAL_PATH} ---"
aws s3 cp "$S3_PATH" "$LOCAL_PATH"
check_error "AWS S3 download failed. Check network connectivity, credentials, and file path."


# --- 4. STOP JENKINS CONTAINER ---
echo "--- 4. Stopping Jenkins container (${JENKINS_CONTAINER_NAME}) to ensure data integrity ---"
docker stop "$JENKINS_CONTAINER_NAME"
check_error "Failed to stop Jenkins container. Ensure the container name is correct."


# --- 5. EXTRACT DATA TO DOCKER VOLUME ---
echo "--- 5. Restoring data from ${RESTORE_FILE_NAME} into Docker volume: ${DOCKER_VOLUME_NAME} ---"
# We use an Alpine container to extract the files directly into the Docker volume.
docker run --rm \
    -v "$DOCKER_VOLUME_NAME":"$CONTAINER_VOLUME_PATH" \
    -v "$TEMP_DOWNLOAD_DIR":/backup:ro \
    alpine:latest \
    /bin/sh -c "cd $CONTAINER_VOLUME_PATH && tar -xzf /backup/$RESTORE_FILE_NAME --strip-components 1"

check_error "Failed to extract backup data into the Docker volume."


# --- 6. CLEANUP AND RESTART ---
echo "--- 6. Cleaning up temporary files and restarting Jenkins ---"

# Delete the temporary download directory and its contents
rm -rf "$TEMP_DOWNLOAD_DIR"

# Restart the original Jenkins container
docker start "$JENKINS_CONTAINER_NAME"
check_error "Failed to restart Jenkins container. Manual restart may be required."

echo "=========================================================================="
echo "✅ RESTORE COMPLETE! Jenkins should be restarting now."
echo "Verify Jenkins status with: docker ps -a"
echo "=========================================================================="

