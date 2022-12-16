pipeline {
    agent any
    stages {
        stage('Verify branch') {
            steps {
                echo "$GIT_BRANCH"
            }
        }
        stage('Build & Dockerize') {
            steps {
                    sh(script:"""
                    #!/bin/bash
                    ls
                    docker build . -t gradproj/ausf:latest
                    """)
            }
        }
        stage('Push Container') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'Docker') {
                    sh(script:"""
                    docker tag free5gc/base:latest gradproj/base:latest
                    docker push gradproj/base:latest
                    docker push gradproj/ausf:latest
                    """)
                    }
                }
            }
        }
    }
    post{
        success{
            echo ':)'
        }
        failure{
            echo ':('
        }
    }
}