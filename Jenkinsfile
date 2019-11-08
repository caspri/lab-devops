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
        DockerImage = docker.build registry + ":v$BUILD_NUMBER" + "latest" 
        }
      }
    }

    stage('Upload Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
          DockerImage.push()
          }
        }
      }
    }

    stage('Remove Unused docker image') {
      steps{
        script {
          sh "docker rmi DockerImage"
        }
      }
    }
  }
}
