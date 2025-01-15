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
	stage('Artifactory configuration') {
	    steps{
		rtMavenDeployer (
                    id: "MAVEN_DEPLOYER",
                    serverId: "artifactory-server",
                    releaseRepo: maven-repo,
                    snapshotRepo: maven-repo
                )
	    }
	}
        stage('Scan and Build Jar File') {
            steps {
                withSonarQubeEnv(installationName: 'SonarQube', credentialsId: 'jenkins-sonar') {
                    sh 'mvn clean package sonar:sonar'
                }
	    rtMavenRun (
                    tool: maven, // Tool name from Jenkins configuration
                    pom: 'pom.xml',
                    goals: 'clean install',
                    deployerId: "MAVEN_DEPLOYER"
                )
            rtPublishBuildInfo (
   		 serverId: 'artifactory-server'
		) 
            }
        }
    }
}
