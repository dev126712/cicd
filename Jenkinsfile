pipeline {

    agent any

    tools {}

    environment {
        SCANNER_HOME= tool 'sonar-scanner'
    }

    stages {

        stage("git checkout") {
            
            steps {}
        }

        stage("") {
            
            steps {}
        }

        stage("file system scan") {
            
            steps {
                sh "trivy fs --format table -o trivy-fs-report.html ."
            }

        }

        stage("sonarQube Analisys") {
            
            steps {
                withSonarQubeEnv('sonar')
                sh '''
                    $SCANNER_HOME/bin/sonar-scanner -sonar.projectName= -Dsonar.projectKey-BoardGame \
                      -Dsonar.java.binaries=. '''
            }
        }

        stage("Quality gate") {
            
            steps {
                script {
                    waitForQualityGate abortPipeline: false, credentialsId: 'sonar-token'
                }
            }
        }

        stage("build") {
            
            steps {
                sh "npm run build"
            }
        }

        stage("publish to nexus") {
            
            steps {}
        }

        stage("Build and tag Docker Images") {
            
            steps {
                withDockerRegistry(credentialsId: 'docker-cred', toolName: 'docker') {
                    sh "docker build -t dev126712/dockerized-three-tier-app-backend:latest"
                }
            }
        }

        stage("Docker Image Scan") {
            
            steps {
                sh "trivy image --format table -o trivy-fs-report.html dev126712/dockerized-three-tier-app-backend:latest"
            }

        }

        stage("Push Docker Image") {
            
            steps {
                sh "docker push dev126712/dockerized-three-tier-app-backend:latest"
            }
        }
    }
}