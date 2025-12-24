pipeline {
  agent any
  
  // Define environment variables here
  environment {
    IMAGE_NAME = '50in/my_cicd_image'
    IMAGE_TAG  = 'latest'
  }

  stages {
    // Stage 1: Git Checkout
    stage('Git Checkout') {
      steps {
        checkout scm  // Checkout the source code
      }
    }
    
    // Stage 2: Application Build
    stage('Application Build') {
      steps {
        sh 'chmod +x scripts/build.sh'  // Ensure the build script is executable
        sh 'scripts/build.sh'           // Execute the build script
      }
    }

    // Stage 3: Tests
    stage('Tests') {
      steps {
        sh 'chmod +x scripts/test.sh'   // Ensure the test script is executable
        sh 'scripts/test.sh'            // Execute the test script
      }
    }

    // Stage 4: Docker Image Build
    stage('Docker Image Build') {
      steps {
        sh "docker build --platform linux/arm64/v8 -t ${IMAGE_NAME}:${IMAGE_TAG} ."  // Build the Docker image
      }
    }

    // Stage 5: Docker Image Push
    stage('Docker Image Push') {
      steps {
    withCredentials([usernamePassword(
        credentialsId: 'dockerhub-creds',  // Credentials ID in Jenkins for Docker Hub
        usernameVariable: 'DOCKER_USER',   // Username environment variable
        passwordVariable: 'DOCKER_PASS'    // Password environment variable
    )]) {
      sh '''
        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
        docker push ${IMAGE_NAME}:${IMAGE_TAG}
      '''
    }
  }
}
  }
}
