#!/usr/bin/env bash
set -x
APP_HOME="/var/www/unleash-it"
SCRIPTS_HOME="${APP_HOME}/scripts"
BACKEND_HOME="${APP_HOME}/backend"
SCRIPTS_BACKEND_HOME="${SCRIPTS_HOME}/backend"
STOP_SERVICES="${SCRIPTS_BACKEND_HOME}/stop_services.sh casp-service-registry"
START_SERVICES="${SCRIPTS_BACKEND_HOME}/start_services.sh casp-service-registry"
USER_NAME="dev_unleashit"
HOST_NAME=${1}
PORT_NAME=${2}


function ssh_cmd() {
    local cmd_to_run=${1}
    ssh -p ${PORT_NAME} ${USER_NAME}@${HOST_NAME} "${cmd_to_run}" >/dev/null 2>&1
}

case "${1}" in
  help)
    echo "Usage: $(basename ${0}) \"193.30.120.113\" 2222"
    echo "Usage: $(basename ${0}) \"v22019017762182298.nicesrv.de\" 22"
    exit 0
esac

ssh_cmd "echo \"hello world!\""

ssh_cmd "${STOP_SERVICES}"

ssh_cmd "${START_SERVICES}"
