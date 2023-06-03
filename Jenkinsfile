pipeline {

    agent any

    environment {
        UPDATE_SERVICE_SCRIPT = '/home/luisribeiro/docker-swarm/update_service.sh'
        DOCKER_TAG = 'latest'
        DOCKER_COMPOSE_FILE_NAME = 'casp-uat.yml'
        REPOSITORY_NAME_PREFIX = 'lacribeiro11'
    }
    options {
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr:'5'))
    }

    tools {
        maven "Default"
    }

    stages {
        stage('MongoDB Setup') {
            steps {
                script {
                    createMongoDbContainer()
                }
            }
        }
        stage('Maven Build') {
            steps {
                script {
                    sh 'mvn -B clean verify'
                }
            }
        }
        stage('Docker Build and Push'){
            when {
                branch 'develop'
            }
            steps {
                dockerBuildAndPush('$REPOSITORY_NAME_PREFIX/registry', '$DOCKER_TAG', '')
            }
        }
        stage('Restart Service'){
            when {
                branch 'develop'
            }
            steps {
                restartService('$UPDATE_SERVICE_SCRIPT', '$REPOSITORY_NAME_PREFIX', 'registry', '$DOCKER_TAG', '$DOCKER_COMPOSE_FILE_NAME')
            }
        }
    }

}
// TODO These functions should all be moved to the new pipeline library
// https://github.com/asgreflexx/casp-utility-scripts/issues/3
void createMongoDbContainer() {
    removeMongoDbContainer()
    sh 'docker pull mongo:latest'
    sh 'docker run -d --name mongo_unittest -p 27017:27017 mongo:latest'
}

void removeMongoDbContainer() {
    try {
        sh 'docker stop mongo_unittest'
        sh 'docker rm mongo_unittest'
    } catch (err) {
        echo 'docker mongo_unittest is not already running' // err.getMessage()
    }
}

void dockerBuildAndPush(String repositoryName, String tag, String dockerfileDirectoryPath) {
    String fullName = "${repositoryName}:${tag}"
    sh "docker build -t ${fullName} -f Dockerfile ."
    sh "docker push ${fullName}"
}

void restartService(String updateServiceScript, String repositoryNamePrefix, String repositoryNameSuffix, String tag, String dockerComposeFilename) {
    sh "${updateServiceScript} ${repositoryNamePrefix} ${repositoryNameSuffix} ${tag} caspstack ${dockerComposeFilename}"
}
