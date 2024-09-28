/**
 * Author:      Joachim Brunbauer
 * Create Date: 2024-09-07
 * Description: Jenkins Declarative Pipeline Definition (more recent than scripted Pipelines)
 */
pipeline {
    agent { label 'jenkins-agent1'
        /*
        docker { 
            image 'database/sqlcl:24.2.0'
            registryUrl 'https://container-registry.oracle.com/'
            registryCredentialsId 'repo_orcl'
            args '-v jenkins_agent_workspace:/opt/oracle/sql_scripts --entrypoint='
        }
        */      
    }
    options { buildDiscarder(logRotator (numToKeepStr: '5')) }
    
    stages {
        stage('Init') {
            steps {
                echo 'Info: Init' 
                // dir('DATABASE/HR') {
                /*
                dir('DATABASE') {
                    script {
                        def output = sh(returnStdout: true, script: 'pwd')
                        echo "Output: ${output}"
                        sh 'sqlcl'
                        sh 'connect HR/charly77@jdbc:oracle:thin:@//192.168.0.5:1521/ORCLPDB1'
                        sh 'version'
                    }
                }   
                */                          
                /* Check if we got liquibase in version 4.29.2 */
                /* sh 'liquibase --version' */
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
            agent {
                docker {
                    image 'container-registry.oracle.com/database/sqlcl:24.1.0'
                    args '-v jenkins_agent_workspace:/opt/oracle/sql_scripts --entrypoint='
                    reuseNode true
                }
            }  
            steps {
                /* Push changes to Stage environment and compile code */
                echo 'Info: Deploy'
                // sh 'docker run --rm --network="host" -v jenkins_agent_workspace:/opt/oracle/sql_scripts/ dcf14b45dfac HR/charly77@192.168.0.5:1521/ORCLPDB1'                                  
                // sh '/opt/oracle/sqlcl/bin/sql /nolog'
                sh 'ls -la'
                sh 'cd /opt/oracle/sqlcl/bin'
                sh 'sql HR/charly77@jdbc:oracle:thin:@//192.168.0.5:1521/ORCLPDB1 @test.sql'
                // sh 'exit'
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
            // cleanWs()
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
