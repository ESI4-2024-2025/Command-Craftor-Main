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

RUN_DIR=/commandCraftor/command_craftor
NGINX_DIR=/var/www/commandcraftor.ebasson.fr

echo_and_log "Copying sources into ${RUN_DIR}..."
_e rsync -rt --partial --delete-after --exclude='.env' . "${RUN_DIR}" || exit 1

echo_and_log "Installing dependencies"
_e pushd "${DEST_DIR}" &> /dev/null || exit 1
_e npm install || exit 1

_e npm run build || exit 1
_e rsync -rt --partial --delete-after build/* "${NGINX_DIR}" || exit 1
