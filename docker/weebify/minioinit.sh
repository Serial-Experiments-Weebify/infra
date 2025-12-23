# check for vars
if [ -z "$WEEBIFY_CREATE_BUCKET" ]; then
    exit 1
fi

sleep 5

echo "Weebify minio init script"

if [ -n "$MINIO_ROOT_USER_FILE" ] && [ -f "$MINIO_ROOT_USER_FILE" ]; then
    export MINIO_ROOT_USER=$(cat $MINIO_ROOT_USER_FILE)
fi

if [ -n "$MINIO_ROOT_PASSWORD_FILE" ] && [ -f "$MINIO_ROOT_PASSWORD_FILE" ]; then
    export MINIO_ROOT_PASSWORD=$(cat $MINIO_ROOT_PASSWORD_FILE)
fi

if [ -z "$MINIO_ROOT_USER" ] || [ -z "$MINIO_ROOT_PASSWORD" ]; then
    echo "MINIO_ROOT_USER or MINIO_ROOT_PASSWORD not set"
    exit 1
fi

# set credentials
mc alias set s3 http://minio:9000 $MINIO_ROOT_USER $MINIO_ROOT_PASSWORD
sleep 1

# check if bucket exists;
# TODO: no grep lol
mc ls s3 --json | grep "\"key\":\"$WEEBIFY_CREATE_BUCKET\""
if [ $? -eq 0 ]; then
    echo "Bucket already exists"
    exit 0
fi

echo "Creating bucket"

# create bucket
mc mb s3/$WEEBIFY_CREATE_BUCKET

# set policy
mc anonymous set download s3/weebify
