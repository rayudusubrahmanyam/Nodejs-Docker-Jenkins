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
        stage('Code Quality Check via SonarQube') {
            steps {
                script {
                def scannerHome = tool 'SonarQube';
                    withSonarQubeEnv("SonarQube") {
                    sh "${tool("SonarQube")}/bin/sonar-scanner \
                    -Dsonar.projectKey=test-node-js \
                    -Dsonar.sources=. \
                    -Dsonar.css.node=. \
                    -Dsonar.host.url=http://ec2-13-233-87-57.ap-south-1.compute.amazonaws.com:9000 \
                    -Dsonar.login=d400c4e72f91f3b7ae1ff12bcacda2a0754b2948"
                        }
                    }
                }
            }
/*
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
                  def ec2_Instance = "ubuntu@${EC2_INSTANCE_PUBLIC_IP}"
                  def shellCmd = "sudo docker run -d -p 8080:8080 rayudusubrahmanyam/nodewebapp:${BUILD_NUMBER}.0"
                sshagent(['webapp-ssh-key']){
                    sh "ssh -o StrictHostKeyChecking=no ${ec2_Instance} ${shellCmd}"
                  }   
                }
            }
        } */ 
     }
}
