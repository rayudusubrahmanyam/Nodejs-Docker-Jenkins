@Library("jenkins-shared-lib")_
pipeline {
     agent {
        docker {
            image 'node:lts-buster-slim' 
            args '-p 3000:3000' 
        }
      }
      stages {
        stage('Fetch Repository') {
            steps {
                script {
                    git branch: 'main', credentialsId: 'Github', url: 'https://github.com/rayudusubrahmanyam/Nodejs-Docker-Jenkins.git'
                }
                
            }
        }
        stage('NPM Install') {
            steps {
                npmInstall();
            }
        }
        stage('Docker Image Build and Push') {
            steps {
                script {
                   buildDockerImage("rayudusubrahmanyam/nodewebapp:$BUILD_NUMBER.0")
                   dockerLogin();
                   dockerPush("rayudusubrahmanyam/nodewebapp:$BUILD_NUMBER.0");
                }
            }
        }    

    } 
}
