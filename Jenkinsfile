//file:noinspection GroovyAssignabilityCheck
//noinspection GroovyUnusedAssignment
@Library('Common@develop') _
import casp.common.Environment
import casp.common.Service

pipeline {

    agent any

    options {
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr:'5'))
    }

    tools {
        maven "Default"
    }

    stages {
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
                buildImageAndPush(Service.REGISTRY)
            }
        }
        stage('Restart Service'){
            when {
                branch 'develop'
            }
            steps {
                updateAndRestartService(Environment.TEST, Service.REGISTRY)
            }
        }
    }
}
