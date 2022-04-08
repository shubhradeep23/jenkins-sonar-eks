pipeline {
        environment {
          imagename = "shubhradeepghosh23/java:latest"
          registryCredential = 'dockerhub-creds'
          dockerImage = ''
    }
        agent any
        tools {
            jdk 'jdk11'
            maven 'maven3'
    }
        stages {
          stage("build & SonarQube analysis") {
            agent any
            steps {
              withSonarQubeEnv('sonar') {
                sh 'mvn clean package sonar:sonar'
              }
            }
          }
          stage("Quality Gate") {
            steps {
              timeout(time: 1, unit: 'HOURS') {
                waitForQualityGate abortPipeline: true
              }
            }
          }
          stage('Building image') {
            steps{
              script {
                dockerImage = docker.build imagename
              }
            }
          }
          stage('Deploy Image') {
            steps{
              script {
                docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) {
                dockerImage.push("$BUILD_NUMBER")
                dockerImage.push('latest')

              }
            }
          }
        }
           stage('K8S Deploy') {
             steps{   
              script {
                withKubeConfig([credentialsId: 'eks-shubhradeep', serverUrl: '']) {
                sh ('kubectl apply -f eks-deploy-k8s.yaml')
         }
       }
     }
   }
}
      post {
        always {
          cleanWs()
        }
      }
    }

      