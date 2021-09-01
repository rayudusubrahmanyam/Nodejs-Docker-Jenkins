pipeline{
    node any
 stages{
     stage("Fetch Source Code")
     {
         script{
             git branch: 'main', credentialsId: 'GitHub', url: 'https://github.com/rayudusubrahmanyam/Nodejs-Docker-Jenkins.git'
         }
     }
 }    
}