pipeline {
    environment {
        registry = "linea/postgresql_q3c"
        registryCredential = 'Dockerhub'
        dockerImage = ''
    }
    agent any

    stages {
        stage('Test') {
            steps {
                sh 'echo test'
            }
        }
        stage('Building and push image') {
            when {
                expression {
                   env.BRANCH_NAME.toString().equals('master')
                }
            }
            steps {
                script {
                dockerImage = docker.build registry + ":$GIT_COMMIT"
                docker.withRegistry( '', registryCredential ) {
                dockerImage.push()
                }
                sh "docker rmi $registry:$GIT_COMMIT"
            }
        }
    }
  }
}