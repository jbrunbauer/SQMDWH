/**
 * Author:      Joachim Brunbauer
 * Create Date: 2024-09-07
 * Description: Jenkins Declarative Pipeline Definition (more recent than scripted Pipelines)
 */
pipeline {
    agent { 
        node { label 'jenkins-agent1' } 
        /* Be sure that docker is installed on Jenkins Agent */
        docker { image 'liquibase/liquibase:4.29.2' }
    }
    tools {
        docker 'docker-latest'
        /* jdk 'openJDK 17.0.12' */
    }    
    options { buildDiscarder(logRotator (numToKeepStr: '5')) }
    
    stages {
        stage('Status') {
            steps {
                /* Check if we got liquibase in version 4.29.2 */
                echo 'Info: Status'                
                sh 'liquibase --version'
                /* sh 'liquibase status --url="jdbc:oracle:thin:@//172.18.0.4:1521/ORCLPDB1" --changeLogFile=masterChangeLog.sql --username=HR --password=charly77' */
            }
        }
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
                /* sh 'liquibase update --url="jdbc:oracle:thin:@//172.18.0.4:1521/ORCLPDB1" --changeLogFile=masterChangeLog.sql --username=HR --password=charly77'
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
            /* Clean up the Workspace */
            /* cleanWs() */
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
