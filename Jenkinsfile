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
		script {
                    def server = Artifactory.server('central') // Artifactory Server ID in Jenkins
                    def rtMaven = Artifactory.newMavenBuild()

                    rtMaven.resolver server: server, releaseRepo: 'maven-repo'
                    rtMaven.deployer server: server, releaseRepo: 'maven-repo'

                    rtMaven.run pom: 'pom.xml', goals: 'clean deploy'
                }
            }
        }
    }
}
