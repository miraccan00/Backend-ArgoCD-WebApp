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
                    sh 'sudo helm list'

                    // Modify the values.yaml file to set the image tag
                    sh "sudo sed -i 's/\\(image:\\s*tag:\\s*\\).*/\\1${env.BUILD_NUMBER}/' helmchart/myvalues.yaml"

                    // Deploy (or upgrade) your Helm release
                    sh "sudo helm upgrade --install servicename helmchart/ --namespace default -f helmchart/myvalues.yaml"

                    // List Helm releases and version for debugging
                    sh 'sudohelm version'
                    sh 'sudo helm list'

                    echo 'Deployed!'
                }
            }
            }

    }
}
