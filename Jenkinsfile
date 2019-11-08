pipeline {
  environment {
    registry = "chr93/trg_demo"
    registryCredential = 'docker-hub-credentials'
    DockerImage = ''
  }
  agent any
  stages {
    stage('Pull from github') {
      steps{
         git 'https://github.com/caspri/lab-devops.git'
      }
    }

    stage('Building image') {
      steps{
        script {
        DockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }

    stage('Test') {
      steps{
         script {
            sh "docker run -p 5000:5000 $registry:$BUILD_NUMBER test"
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
          sh "docker rmi $registry:$BUILD_NUMBER"
        }
      }
    }
  }
}
