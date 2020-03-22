#!/usr/bin/env bash
set -x
KUBERNETES_HOME="$( dirname "${BASH_SOURCE[0]}")"
APP_HOME="$( dirname "${KUBERNETES_HOME}")"
APP_PORT="19990"
APP_NAME="casp-registry-service"
DOCKER_IMAGE="lacribeiro11/${APP_NAME}"
KUBERNETES_DEPLOYMENT="${KUBERNETES_HOME}/deployment.yaml"

mvn clean install -f "${APP_HOME}/pom.xml"
cp "${APP_HOME}/target/${APP_NAME}.jar" "${KUBERNETES_HOME}/"

docker build -t ${DOCKER_IMAGE}:latest .
#docker run -p ${APP_PORT}:${APP_PORT} ${DOCKER_IMAGE} > ${APP_NAME}.log 2>&1 &
#sleep 10
#curl localhost:${APP_PORT}/actuator/health

docker push ${DOCKER_IMAGE}
kubectl delete -n default deployment ${APP_NAME}
kubectl delete -n default service ${APP_NAME}
kubectl create deployment ${APP_NAME} --image=${DOCKER_IMAGE} -o=yaml > ${KUBERNETES_DEPLOYMENT}
kubectl create service clusterip ${APP_NAME} --tcp=${APP_PORT}:${APP_PORT} -o=yaml >> ${KUBERNETES_DEPLOYMENT}

# kubectl apply -f ${KUBERNETES_DEPLOYMENT}

sleep 10
kubectl get all

kubectl port-forward svc/${APP_NAME} ${APP_PORT}:${APP_PORT} # > "${KUBERNETES_HOME}/${APP_NAME}.log" 2>&1 &

#sleep 10
#
#curl localhost:${APP_PORT}/actuator/health

#kubectl delete -n default deployment casp-registr-service
#kubectl create deployment casp-registry-service --image=lacribeiro11/casp-registry-service
#kubectl delete -n default service casp-registry-service
#kubectl apply -f create-casp-service-registry.yml
#sleep 5
#export POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
#for i in {1..30}
#do
#
#    if [[ "${POD_NAME_OLD}" == *"${POD_NAME}"* ]]
#    then
#         POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
#    else
#        break
#    fi
#    sleep 2
#done
#echo "curl http://localhost:8001/api/v1/namespaces/default/pods/${POD_NAME}:${PORT_SERVICE}/proxy/"
#
#export NODE_PORT=$(kubectl get services/casp-registry-service -o go-template='{{(index .spec.ports 0).nodePort}}')
#
#echo "curl $(minikube ip):${NODE_PORT}"
