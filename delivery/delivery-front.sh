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

SOURCES_DIR=/commandCraftor/sources/front/sources/front
RUN_DIR=/commandCraftor/command_craftor
NGINX_DIR=/var/www/commandcraftor.ebasson.fr

if [ -e "${SOURCES_DIR}/delivery.lock" ]
then
    echo_and_log "Une livraison est en cours, réessayer plus tard. Supprimer delivery.lock si ça n'est pas le cas."
    exit 1
else
    _e touch "${SOURCES_DIR}/delivery.lock" || exit 1
fi


echo_and_log "Copying sources into ${RUN_DIR}..."
_e rsync -rt --partial --delete-after --exclude='.env' "${SOURCES_DIR}/" "${RUN_DIR}/" || exit 1

echo_and_log "Installing dependencies"
_e pushd "${RUN_DIR}" &> /dev/null || exit 1
_e npm install || exit 1

_e npm run build || exit 1
_e rsync -rt --partial --delete-after build/ "${NGINX_DIR}/" || exit 1

_e popd &> /dev/null || exit 1

_e rm "${SOURCES_DIR}/delivery.lock" || exit 1