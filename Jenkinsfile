node{
   stage('SCM Checkout'){
       git credentialsId: 'git-creds', url: 'https://github.com/javahometech/my-app'
   }
   stage('Mvn Package'){
     def mvnHome = tool name: 'maven-3', type: 'maven'
     def mvnCMD = "${mvnHome}/bin/mvn"
     sh "${mvnCMD} clean package"
   }
   stage('Build Docker Image'){
     sh 'docker build -t abdelrazekrizk/my-app:2.0.0 .'
   }
   stage('Push Docker Image'){
     withCredentials([string(credentialsId: 'docker-pw', variable: 'dockerHubPwd')]) {
        sh "docker login -u kammana -p ${dockerHubPwd}"
     }
     sh 'docker push kammana/my-app:2.0.0'
   }
   stage('Run Container on Dev Server'){
     def dockerRun = 'docker run -p 8081:8081 -d --name my-app abdelrazekrizk/my-app:2.0.0'
     sshagent(['dev-server']) {
       sh "ssh -o StrictHostKeyChecking=no ubuntu@ec2-3-232-171-178 ${dockerRun}"
     }
   }
}
