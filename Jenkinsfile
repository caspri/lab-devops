pipeline {
  environment {
    registry = "chr93/trg_demo"
    registryCredential = 'docker-hub-credentials'
  }
  agent any
  triggers {
    pollSCM '* * * * *'
    }
  stages {
    stage('Pull from github') {
      steps{
         git 'https://github.com/caspri/lab-devops.git'
      }
    }

    stage('Building image') {
      steps{
        script {
          docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }

    stage('Test') {
      steps{
        script {
            sh "sudo docker run -p 5000:5000 $registry:$BUILD_NUMBER test"
        }
      }
    }

    stage('Upload Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
          dockerImage.push()
          }
        }
      }
    }

    stage('Remove Unused docker image') {
      steps{
        script {
          sh "sudo docker rmi $registry:$BUILD_NUMBER"
        }
      }
    }
  }
}
