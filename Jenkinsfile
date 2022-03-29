pipeline {
  agent any
  parameters {
        string (name: 'DOCKER_REPO', defaultValue: 'docker-local', description: 'Docker repository for pull/push')
    }
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  environment {
    CI = true
    ARTIFACTORY_ACCESS_TOKEN = credentials('jfrog-access-token')
  }
  stages {
    stage('Build') {
      steps {
        sh './mvnw clean install'
      }
    }
	stage('Setup'){
            steps {
                script{
                    rtServer = Artifactory.newServer url: 'https://jfrogfreerepo.jfrog.io/artifactory/', credentialsId: 'jfrog-access-token'
                    rtDocker = Artifactory.docker server: rtServer
                    privateDockerRegistry = 'https://jfrogfreerepo.jfrog.io/artifactory/'
                }
            }
        }
	stage('Create Image'){
            steps {
                script{
                    def dockerImage = docker.build("${privateDockerRegistry}/${params.DOCKER_REPO}/build-${JOB_NAME}:${BUILD_NUMBER}")
                }
            }
        }
    }
}
