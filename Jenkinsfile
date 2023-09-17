pipeline {
    agent any 

    environment {
        KUBECONFIG = "${WORKSPACE}/kubeconfig" // set KUBECONFIG env var to point to our workspace
    }

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
                    sh 'cp $KUBECONFIG_PATH $KUBECONFIG' // copy secret kubeconfig to workspace
                    sh 'kubectl get pods'
                    sh 'kubectl get pods -A'
                    sh 'kubectl get nodes'
                    sh 'helm version'
                    sh 'helm list'
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