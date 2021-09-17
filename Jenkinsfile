@Library("jenkins-shared-lib")_
pipeline {
     agent any
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

        stage('Server Provisioning') 
        {
            environment {
               AWS_ACCESS_KEY_ID = credentials('jenkins-aws-access-id')
               AWS_SECRET_ACCESS_KEY = credentials('jenkins-aws-access-key')
            }
            steps {
              script {
                dir('terraform') {
                    sh "terraform init"
                    sh "terraform apply --auto-approve"
                }
            }
          }   
        }   
    } 
}
