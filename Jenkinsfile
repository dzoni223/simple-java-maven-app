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
	    rtMavenDeployer (
		id: 'MAVEN_DEPLOYER',
		releaseRepo: 'maven-repo',
		snapshotRepo: 'maven-repo',
		serverId: 'artifactory-server'
		)
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
