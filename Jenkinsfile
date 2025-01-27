pipeline {
    agent any 
    
    environment {
        DOCKER_CREDENTIALS = 'dockerhub-creds'  // Credentials ID for DockerHub
        dockerHubUser = 'rohannegi11'  // DockerHub username
    }

    tools {
        jdk 'jdk11'
        maven 'maven3'
    }

    stages {
        
        stage("Git Checkout") {
            steps {
                git branch: 'main', changelog: false, poll: false, url: 'https://github.com/rohannegi1104/webapp_projct.git'
            }
        }
        
        stage('Build Application') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Test Application') {
            steps {
                sh 'mvn test'
            }
        }
        
        stage("Docker Build & Push") {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS, passwordVariable: 'dockerHubPass', usernameVariable: 'dockerHubUser')]) {
                        sh "docker login -u ${dockerHubUser} -p ${dockerHubPass}"
                        sh "docker build -t ${dockerHubUser}/webapp_project:latest ."
                        sh "docker push ${dockerHubUser}/webapp_project:latest"
                    }
                }
            }
        }

        stage("Run Docker Container") {
            steps {
                script {
                    sh "docker run -itd -p 8083:8083 ${dockerHubUser}/webapp_project:latest"
                }
            }
        }
    }
}
