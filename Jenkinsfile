pipeline {
    agent any 

    stages {
        stage('Checkout') {
            steps {
                checkout([
                    $class: 'GitSCM', 
                    branches: [[name: '*/jenkinstest']], 
                    doGenerateSubmoduleConfigurations: false, 
                    extensions: [], 
                    submoduleCfg: [], 
                    userRemoteConfigs: [[url: 'https://github.com/miraccan00/djangoworkshop/']]
                ])
            }
        }

        stage('Build in Docker') {
            steps {
                script {
                    sh 'pwd'
                    sh 'ls -lrth'
                }
                
                // Use the withCredentials block to access your kubeconfig secret
                withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG_PATH')]) {
                    // Set the KUBECONFIG environment variable for these commands
                    sh 'export KUBECONFIG=$KUBECONFIG_PATH; sudo helm version'
                    sh 'export KUBECONFIG=$KUBECONFIG_PATH; sudo helm list'
                }
            }
        }

        stage('push to dockerhub') {
            steps {
                script {
                    echo 'pushing...'
                }
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying...'
                // your deployment steps
            }
        }
    }
}