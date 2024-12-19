#!/bin/bash

function echo_and_log() {
    echo -e "$CYAN \n$1 $NORMAL";
    echo "$1" >> "${LOG_PATH}"
}

function _e() {
    echo "$*"
    "$@"
     if [ $? != 0 ]
     then
         echo_and_log "Command failed."
         if [ -e "${SOURCES_DIR}/delivery.lock" ]
         then rm "${SOURCES_DIR}/delivery.lock"
         fi
         exit 1
     fi
}

BACK_DIR=/commandCraftor/command_craftor_API

echo_and_log "Restarting services"
_e cd "${BACK_DIR}" || exit 1
_e systemctl restart nginx || exit 1
_e nohup node index.js > /dev/null 2>&1 &
