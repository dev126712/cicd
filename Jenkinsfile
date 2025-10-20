pipeline {
    agent any
    stages {
        stage("Verify tooling") {
            steps {
                sh '''
                    docker info
                    docker version
                    dockercompose version
                    curl --version
                    jq --version
                    node -v
                    trivy --version
                    git --version
                '''
            }
        }
    }
}