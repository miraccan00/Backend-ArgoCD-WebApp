pipeline {
    agent any 

    stages {
        stage('Checkout') {
            steps {
                // This will checkout the repository from the provided GitHub URL
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
                    sh 'echo get pods without sudo'
                    sh 'kubectl get pods'
                    sh 'echo get pods with sudo'
                    sh 'sudo kubectl get pods'

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