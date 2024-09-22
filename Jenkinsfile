/**
 * Author:      Joachim Brunbauer
 * Create Date: 2024-09-07
 * Description: Jenkins Declarative Pipeline Definition (more recent than scripted Pipelines)
 */
pipeline {
    agent { label 'jenkins-agent1' }
    options { buildDiscarder(logRotator (numToKeepStr: '5')) }
    
    stages {
        stage('Build') {
            steps {
                /* Create Software Package and copy to Jira Folder, finally create docker test container */
                echo 'Info: Build'
                checkout scmGit(branches: [[name: 'main']], browser: github('https://github.com/jbrunbauer/SQMDWH'), extensions: [lfs(), localBranch('main')], userRemoteConfigs: [[url: 'https://github.com/jbrunbauer/SQMDWH']])
                // sh './jenkins/build.sh'
            }    
        }
        stage('Deploy') {
            steps {
                /* Push changes to Stage environment and compile code */
                echo 'Info: Deploy'
                /* sh './jenkins/deploy.sh' */                  
            }    
        }         
        stage('Test') {
            steps {
                /* Automated testing eg. by using utPLSQL, afterwards remove docker test container */
                echo 'Info: Test'
                /* sh './jenkins/test.sh' */                
            }    
        }
    }
    post {
        always {
            echo 'Info: Post always condition'
        }
        success {
            echo 'Info: Post success condition'
            /* mail to: 'jbrunbau@gmail.com', subject: 'Pipeline succeeded', body: 'Pipeline succeeded' */
        }    
        failure {
            echo 'Info: Post failure condition'            
            /* mail to: 'jbrunbau@gmail.com', subject: 'Pipeline failed', body: 'Pipeline failed' */
        }
    }    
}
