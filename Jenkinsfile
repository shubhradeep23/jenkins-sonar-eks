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
          stage ('Initialize') {
            steps {
                sh '''
                    echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2_HOME}"
                '''
            }
        }

          stage ('Build') {
            steps {
                sh 'mvn clean -Dmaven.test.failure.ignore=true install' 
            }
            post {
                success {
                    junit 'target/surefire-reports/**/*.xml' 
                }
            }
        }

          stage("SonarQube analysis") {
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
          stage('Building docker image') {
            steps{
              script {
                dockerImage = docker.build imagename
              }
            }
          }
          stage('Push Image to Docker Registry') {
            steps{
              script {
                docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) {
                dockerImage.push("$BUILD_NUMBER")
                dockerImage.push('latest')

              }
            }
          }
        }
           stage('Deploy to Kubernetes Cluster (EKS)') {
             steps{   
              script {
                withKubeConfig([credentialsId: 'eks-shubhradeep', serverUrl: '']) {
                sh ('kubectl apply -f eks-deploy-k8s.yaml')
         }
       }
     }
   }
/*           stage('Curl ELB url to test if App is reachable') {
             steps{
               script {
                 retry(5) {
                   sh 'curl <elb-url>/greeting'
                 }
               }
             }
           }
*/}
      post {
        always {
          cleanWs()
        }
      }
    }

      