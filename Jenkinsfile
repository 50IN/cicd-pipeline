pipeline {
    agent any

    environment {
        IMAGE_NAME = "50in/my_cicd_image"  // Docker image name with your username
        IMAGE_TAG  = "latest"  // Tag for the image
    }

    stages {

        // Activity 1: Git Checkout
        // This stage checks out the latest code from the GitHub repository.
        stage('Git Checkout') {
            steps {
                checkout scm  // This pulls the latest code from the Git repository
            }
        }

        // Activity 2: Application Build
        // This stage runs the build script to compile the application.
        stage('Application Build') {
            steps {
                sh 'chmod +x scripts/build.sh'  // Ensure the build script is executable
                sh 'scripts/build.sh'  // Run the build script to build the application
            }
        }

        // Activity 3: Tests
        // This stage runs the tests for the application.
        stage('Tests') {
            steps {
                sh 'chmod +x scripts/test.sh'  // Ensure the test script is executable
                sh 'scripts/test.sh'  // Run the test script to check the application
            }
        }

        // Activity 4: Docker Image Build
        // This stage builds a Docker image for the application.
        stage('Docker Image Build') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."  // Build the Docker image with the tag
            }
        }

        // Activity 5: Docker Image Push
        // This stage pushes the Docker image to the Docker Hub registry.
        stage('Docker Image Push') {
            steps {
                withCredentials([usernamePassword(
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
}
