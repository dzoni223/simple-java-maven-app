pipeline {
    agent any
    environment {
        SONAR_HOST_URL = 'http://sonarqube:9000' // SonarQube URL
        SONARQUBE_CREDENTIALS = 'jenkins-sonar' // Jenkins credentials for SonarQube
        ARTIFACTORY_SERVER = 'artifactory-server' // Artifactory server ID in Jenkins
    }
    stages {
	stage ('Artifactory configuration') {
	    steps{
	        rtMavenDeployer (
                    id: "MAVEN_DEPLOYER",
                    serverId: "artifactory-server",
                    releaseRepo: 'maven-repo',
                    snapshotRepo: 'maven-repo',
		    deployArtifacts: true
                )
	    }	
    	}
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
		rtMavenRun (
                    tool: maven, // Tool name from Jenkins configuration
                    pom: 'pom.xml',
                    goals: 'clean install',
                    deployerId: "MAVEN_DEPLOYER",
                )
		rtPublishBuildInfo (
                    serverId: "ARTIFACTORY_SERVER"
                )                
            }
        }
    }
}

