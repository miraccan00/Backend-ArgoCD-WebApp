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
                    // Build the Docker image with the Docker Hub name format
                    sh "echo servicename will build ..."
                    def appImage = docker.build("miraccan/servicename:${env.BUILD_NUMBER}", "./servicename")
                    sh 'echo servicename build done'
                    sh 'docker images'
                }
            }
        }

        stage('push to dockerhub') {
            steps {
                script {
                    // Define the Docker image with the Docker Hub name format
                    def appImage = docker.image("miraccan/servicename:${env.BUILD_NUMBER}")

                    // Log in to DockerHub and push the image
                    withDockerRegistry([credentialsId: 'dockerhub_credentials', url: 'https://index.docker.io/v1/']) {
                        appImage.push()
                    }
                }
            }
        }
        

        stage('Deploy Helm Chart') {
    steps {
        script {
            // List existing Helm releases
            sh 'helm list'

            // Modify the values.yaml file to set the image tag
            sh "sed -i 's/\\\$tag/${env.BUILD_NUMBER}/g' helmchart/values.yaml"

            // Deploy (or upgrade) your Helm release
            sh "helm upgrade --install servicename helmchart/ --namespace default"

            // List Helm releases and version for debugging
            sh 'helm version'
            sh 'helm list'

            echo 'Deployed!'
        }
    }
}
    }
}
