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
                    EC2_INSTANCE_PUBLIC_IP = sh (
                        script: "terraform output ec2-public-ip" ,
                        returnStdout: true 
                        ).trim()
                }
            }
          }   
        }   

        stage('Deployment') 
        {
            steps {
              script {
                  sleep(time: 90, unit: "SECONDS")
                  def ec2_Instace = "ubuntu@${EC2_INSTANCE_PUBLIC_IP}"
                  def shellCmd = "sudo docker run -d -p 8080:8080 rayudusubrahmanyam/nodewebapp:${BUILD_NUMBER}.0"
                sshagent(['webapp-ssh-key']){
                    sh "ssh -o StrictHostKeyChecking=no ${ec2_Instance} ${shellCmd}"
                  }   
                }
            }
        }  
     }
}
