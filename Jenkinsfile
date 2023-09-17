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
                    sh 'ls -la'
                    // Build the Docker image from the Dockerfile in the 'servicename' directory
                    sh "echo servicename will build ..."
                    def appImage = docker.build("servicename:${env.BUILD_NUMBER}", "./servicename")
                    sh 'echo servicename build done'
                }
            }
        }

        
        
        stage('push to dockerhub') {
            steps {
                script {
                    // Define the Docker image with tag
                    def appImage = docker.image("miraccan/servicename:${env.BUILD_NUMBER}")

                    // Log in to DockerHub and push the image
                    withDockerRegistry([credentialsId: 'dockerhub_credentials', url: 'https://index.docker.io/v1/']) {
                        appImage.push()
                    }
                }
            }
        }
        

        stage('Deploy') {
             steps {
                script {
                    sh 'pwd'
                    sh 'ls -lrth'
                }
                
                // Use the withCredentials block to access your kubeconfig secret
                withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG_PATH')]) {
                    // Set the KUBECONFIG environment variable for these commands
                    sh 'export KUBECONFIG=$KUBECONFIG_PATH; helm version'
                    sh 'export KUBECONFIG=$KUBECONFIG_PATH; helm list'
                }
            }
        }
    }
}
