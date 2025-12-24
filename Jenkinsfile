pipeline {
  agent any
  stages {
    stage('Git Checkout') {
      steps {
        checkout scm
      }
    }
    
    stage('Application Build') {
      steps {
        sh 'chmod +x scripts/build.sh'
        sh 'scripts/build.sh'
      }
    }

    stage('Tests') {
      steps {
        sh 'chmod +x scripts/test.sh'
        sh 'scripts/test.sh'
      }
    }

stages {
        stage('Docker Image Build') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."  // Build the Docker image
            }
        }
    }

    

    stage('Docker Image Push') {
      steps {
        withCredentials(bindings: [usernamePassword(
                                                  credentialsId: 'dockerhub-creds',  // Use Jenkins credentials for Docker Hub
                                                  usernameVariable: 'DOCKER_USER',   // Set Docker username
                                                  passwordVariable: 'DOCKER_PASS'    // Set Docker password
                                              )]) {
            sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin  // Login to Docker Hub
                        docker push ${IMAGE_NAME}:${IMAGE_TAG}  // Push the Docker image to the registry
                    '''
          }

        }
      }

    }
    environment {
      IMAGE_NAME = '50in/my_cicd_image'
      IMAGE_TAG = 'latest'
    }
  }
