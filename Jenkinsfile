pipeline {
    agent { label 'agent1' }
    options { buildDiscarder(logRotator (numToKeepStr: '5')) }
    
    stages {
        stage('Build') {
            steps {
                echo 'Info: Build'
                // sh './jenkins/build.sh'
            }    
        }
    }
    stages {
        stage('Test') {
            steps {
                echo 'Info: Test'
                // sh './jenkins/test.sh'                
            }    
        }
    }  
    stages {
        stage('Deploy') {
            steps {
                echo 'Info: Deploy'
                // sh './jenkins/deploy.sh'                  
            }    
        }
    }    
}