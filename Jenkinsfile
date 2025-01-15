pipeline {
    agent any
    stages {
        stage('Test SonarQube Connectivity') {
            steps {
                script {
                    sh 'curl -v http://sonarqube:9000'
                }
            }
        }
        stage('Scan and Build Jar File') {
            steps {
                withSonarQubeEnv(installationName: 'SonarQube', credentialsId: 'jenkins-sonar') {
                    sh 'mvn clean package sonar:sonar'
                }
		    sh 'mvn clean install -e -X artifactory:publish -Dartifactory.repoKey=maven-repo'
            }
        }
    }
}
