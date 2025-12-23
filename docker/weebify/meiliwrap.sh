#!/bin/sh

DEFAULT_SECRET_FILE="/run/secrets/searchKey"

SECRET_FILE="${MEILI_SECRET_FILE_PATH:-$DEFAULT_SECRET_FILE}"

if [ -f "$SECRET_FILE" ]; then
  export MEILI_MASTER_KEY=$(cat "$SECRET_FILE")
else
    echo "Error: Secret file '$SECRET_FILE' not found."
    exit 1
fi

echo "Starting MeiliSearch with master key from secret file."
echo "$@"
# Continue with the original entrypoint
exec $@