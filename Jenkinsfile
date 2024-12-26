pipeline {
    agent any
    stages {
        stage('Build') { 
            steps {
                sh 'mvn -B -DskipTests clean package' 
            }
        }
	stage('SonarQube Analysis') {
	            environment {
	                SONARQUBE = 'SonarQube' // the name of the SonarQube server in Jenkins
	            }
	            steps {
	                script {
	                    // Run the SonarQube analysis
	                    sh 'mvn sonar:sonar -Dsonar.host.url=http://localhost:9000'
	                }
	            }
	        }
    }
}
