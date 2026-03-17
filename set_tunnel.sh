#!/bin/bash

# Configurable values
SCREEN_NAME="tunnel"
SSH_USER="usertxm"
SSH_HOST="164.54.102.61"
LOCAL_PORT=$1

# Check if screen session is already running
if screen -list | grep -q "\.${SCREEN_NAME}"; then
    echo "Tunnel is already running in screen session '${SCREEN_NAME}'."
else
    echo "Starting SOCKS tunnel in screen session '${SCREEN_NAME}'..."
    screen -dmS "$SCREEN_NAME" ssh -D "$LOCAL_PORT" -C -N "$SSH_USER@$SSH_HOST"
    echo "Tunnel started on localhost:$LOCAL_PORT"
fi

