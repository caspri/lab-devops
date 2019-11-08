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
    stage('Hello') {
      steps{
        echo 'Starting Pipeline for Flask App'
      }
    }
  }

  stages {
    stage('Pull from github') {
      steps{
         git 'https://github.com/caspri/lab-devops.git'
      }
    }
  }


  stages {
    stage('Building image') {
      steps{
        script {
          docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
  }

  stage('Test') {
    steps{
       script {
          sh "docker run $registry:$BUILD_NUMBER test"
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
