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
        

        stage('Deploy') {
            steps {
                script {
                    sh 'pwd'
                    sh 'ls -lrth'

                    // Replace the $tag in values.yaml with the Jenkins build number
                    sh "sed -i 's/\$tag/${env.BUILD_NUMBER}/g' helmchart/values.yaml"
                    
                    // Optionally print out values.yaml for debugging
                    sh 'cat helmchart/values.yaml'
                    
                    // Use the withCredentials block to access your kubeconfig secret
                    withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG_PATH')]) {
                        // Set the KUBECONFIG environment variable for these commands
                        env.KUBECONFIG = "$KUBECONFIG_PATH"
                        sh 'helm list'
                        // Deploy (or upgrade) your Helm release
                        sh "sed -i 's/\$tag/${env.BUILD_NUMBER}/g' helmchart/values.yaml"
                        sh "helm upgrade --install servicename helmchart/ --namespace default"
                        // Checking helm version and list are kept for debugging
                        sh 'helm version'
                        sh 'helm list'
                        sh 'echo Deployed!'
                    }
                }
            }
        }
    }
}
