@Library("jenkins-shared-lib")_
pipeline {
    agent any
    stages {
        stage('Fetch Repository') {
            steps {
                script {
                    fetchRepo('main','https://github.com/rayudusubrahmanyam/Nodejs-Docker-Jenkins.git')
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
