def rtServer, rtDocker, buildInfo, privateDockerRegistry

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
                    rtServer = Artifactory.newServer url: 'https://jfrogfreerepo.jfrog.io/artifactory/', username: 'drahulgandhi@gmail.com', password: 'Adhvay@2020'
                    rtDocker = Artifactory.docker server: rtServer
                    privateDockerRegistry = 'jfrogfreerepo.jfrog.io/artifactory'
                }
            }
        }
	stage('Create Image'){
            steps {
                script{
                    def dockerImage = docker.build("${privateDockerRegistry}/default-docker-local/${params.DOCKER_REPO}/build-${JOB_NAME}:${BUILD_NUMBER}")
                }
            }
        }
    stage('Deploy Docker Image to Artifactory'){
            steps {
                script {
                    buildInfo = rtDocker.push "${privateDockerRegistry}/default-docker-local/${params.DOCKER_REPO}/build-${JOB_NAME}:${BUILD_NUMBER}", "${params.DOCKER_REPO}"
                }
            }
        }
	stage('Publish'){
            steps {
                script {
                    rtServer.publishBuildInfo buildInfo
                }
            }
        }
    }
}
