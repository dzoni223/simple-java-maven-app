pipeline {
    agent any
    environment {
        // Docker image name and tag
        IMAGE_NAME = 'my-docker-app'
        IMAGE_TAG = 'latest'
        DOCKERHUB_REPO = 'dzoni223/jenkins-pushed-image'
    }
    stages {
       // stage('Checkout Code') {
       //     steps {
                // Pull the source code from the repository
       //         checkout scm
       //     }
       // }
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh """
                    docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
                    """
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKERHUB_USER', passwordVariable: 'DOCKERHUB_PASS')]) {
                    script {
                        // Authenticate Docker with Docker Hub
                        sh """
                        echo "${DOCKERHUB_PASS}" | docker login -u "${DOCKERHUB_USER}" --password-stdin
                        """
                        
                        // Tag the Docker image for Docker Hub
                        sh """
                        docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${DOCKERHUB_REPO}:${IMAGE_TAG}
                        """
                        
                        // Push the image to Docker Hub
                        sh """
                        docker push ${DOCKERHUB_REPO}:${IMAGE_TAG}
                        """
                    }
                }
            }
        }
    }
    post {
        always {
            script {
                // Cleanup local Docker image to save space
                sh """
                docker rmi ${IMAGE_NAME}:${IMAGE_TAG} || true
                docker rmi ${DOCKERHUB_REPO}:${IMAGE_TAG} || true
                """
            }
        }
    }
}

