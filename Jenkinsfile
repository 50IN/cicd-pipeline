// Activity 1: Git Checkout
pipeline {
    agent any

    stages {
        stage('Git Checkout') {
            steps {
                checkout scm  // This pulls the latest code from the Git repository
            }
        }
    }
}

// Activity 2: Application Build
pipeline {
    agent any

    stages {
        stage('Application Build') {
            steps {
                sh 'chmod +x scripts/build.sh'  // Ensure the build script is executable
                sh 'scripts/build.sh'  // Run the build script to build the application
            }
        }
    }
}
