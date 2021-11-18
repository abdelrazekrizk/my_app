node{
   stage('SCM Checkout'){
       git credentialsId: 'git-creds', url: 'https://github.com/abdelrazekrizk/my_app'
   }
   stage('Mvn Package'){
     def mvnHome = tool name: 'maven-3', type: 'maven'
     def mvnCMD = "${mvnHome}/bin/mvn"
     sh "${mvnCMD} clean package"
   }
   stage('Build Docker Image'){
     sh 'docker build -t abdelrazekrizk/web-app:1.0.0 .'
   }
   stage('Push Docker Image'){
     withCredentials([string(credentialsId: 'docker-pw', variable: 'dockerHubPwd')]) {
        sh "docker login -u abdelrazekrizk -p ${dockerHubPwd}"
     }
     sh 'docker push abdelrazekrizk/web-app:1.0.0'
   }
   stage('Run Container on Dev Server'){
     def dockerRun = 'docker run -p 8080:8080 -d --name my-app abdelrazekrizk/web-app:1.0.0'
     sshagent(['dev-server']) {
       sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.80.219 ${dockerRun}"
     }
   }
   stage('Run kubectl on Dev Server'){
     sh 'chmod +x run_kubernete.sh .'
     def kubectlRun = './run_kubernete.sh .'
     sshagent(['dev-server']) {
       sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.80.219 ${kubectlRun}"
     }   
   }
}
