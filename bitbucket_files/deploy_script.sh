#!/usr/bin/env bash
set -x
# TODO This is used only for ba2
APP_HOME="/var/www/ba2_microservices"
SCRIPTS_HOME="${APP_HOME}/scripts"
BACKEND_HOME="${APP_HOME}/backend/bin"
FILE_NAME="casp-registry-service"
EXECUTE_FILE_PATH="${BACKEND_HOME}/${FILE_NAME}.jar"
#SCRIPTS_BACKEND_HOME="${SCRIPTS_HOME}/backend"
#STOP_SERVICES="${SCRIPTS_BACKEND_HOME}/stop_services.sh casp-service-registry"
#START_SERVICES="${SCRIPTS_BACKEND_HOME}/start_services.sh casp-service-registry"
USER_NAME="dev_unleashit"
HOST_NAME=${1}
PORT_NAME=${2}


function ssh_cmd() {
    local cmd_to_run=${1}
    ssh -p ${PORT_NAME} ${USER_NAME}@${HOST_NAME} "${cmd_to_run}" >/dev/null 2>&1
}

function scp_cmd() {
    local source_dir=${1}
    local destination_dir=${2}
    scp -r -P ${PORT_NAME} ${source_dir} ${USER_NAME}@${HOST_NAME}:${destination_dir} >/dev/null 2>&1
}

case "${1}" in
  help)
    echo "Usage: $(basename ${0}) \"193.30.120.113\" 2222"
    echo "Usage: $(basename ${0}) \"v22019017762182298.nicesrv.de\" 22"
    exit 0
esac

ssh_cmd "echo \"hello world!\""

# ssh_cmd "${STOP_SERVICES}"

ssh_cmd "rm -f ${EXECUTE_FILE_PATH}"

scp_cmd "./files_to_deploy/*.jar" "${BACKEND_HOME}/"

ssh_cmd "chmod +x ${EXECUTE_FILE_PATH}"

# ssh_cmd "${START_SERVICES}"
