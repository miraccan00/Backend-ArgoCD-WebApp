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
                withCredentials([file(credentialsId: 'YOUR_JENKINS_SECRET_ID', variable: 'KUBECONFIG_PATH')]) {
                    sh 'cp $KUBECONFIG_PATH $KUBECONFIG' // copy secret kubeconfig to workspace
                    sh 'kubectl get pods'
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