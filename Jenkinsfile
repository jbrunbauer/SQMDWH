/**
 * Author:      Joachim Brunbauer
 * Create Date: 2024-09-08
 * Description: Jenkins Pipeline Definition 
 */
pipeline {
    agent { label 'agent1' }
    options { buildDiscarder(logRotator (numToKeepStr: '5')) }
    
    stages {
        stage('Build') {
            steps {
                /* Create Software Package and copy to Jira Folder, finally create docker test container */
                echo 'Workspace ${env.WORKSPACE}'
                echo 'Info: Build'
                // sh './jenkins/build.sh'
            }    
        }
        stage('Deploy') {
            steps {
                /* Push changes to Stage environment and compile code */
                echo 'Info: Deploy'
                // sh './jenkins/deploy.sh'                  
            }    
        }         
        stage('Test') {
            steps {
                /* Automated testing eg. by using utPLSQL, afterwards remove docker test container */
                echo 'Info: Test'
                // sh './jenkins/test.sh'                
            }    
        }
        post {
            always {
                echo 'Post always condition'
            }
            success {
                echo 'Post success condition'
            }    
            failure {
                mail to: 'jbrunbau@gmail.com', subject: 'Pipeline failed'
            }
        }
    }
}
