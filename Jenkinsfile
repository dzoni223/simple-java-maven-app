pipeline {
    agent any
    tools {
        maven 'maven' // Replace 'Maven' with the name of your Maven installation in Jenkins
    }
    environment {
        SONAR_HOST_URL = 'http://sonarqube:9000' // SonarQube URL
        SONARQUBE_CREDENTIALS = 'jenkins-sonar' // Jenkins credentials for SonarQube
        ARTIFACTORY_SERVER = 'artifactory-server' // Artifactory server ID in Jenkins
    }
    stages {
        stage('Test SonarQube Connectivity') {
            steps {
                script {
                    sh 'curl -v $SONAR_HOST_URL'
                }
            }
        }
        stage('Scan and Build Jar File') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh 'mvn clean package sonar:sonar'
                }
            }
        }
        stage('Deploy to Artifactory') {
            steps {
                script {
                    def server = Artifactory.server(env.ARTIFACTORY_SERVER)
                    def rtMaven = Artifactory.newMavenBuild()
                    
                    rtMaven.tool = 'Maven' // Name of Maven tool in Jenkins
                    rtMaven.deployer server: server, 
                                     releaseRepo: 'maven-repo', 
                                     snapshotRepo: 'maven-repo'
                    
                    rtMaven.run pom: 'pom.xml', goals: 'clean deploy'
                    
                    server.publishBuildInfo(rtMaven.deployer)
                }
            }
        }
    }
}

