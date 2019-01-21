pipeline {
    agent any
    parameters {
        string(name: 'tomcat_dev', defaultValue: '3.16.138.0', description: 'Staging Server')
        string(name: 'tomcat_prod', defaultValue: '', description: 'Production Server' )
    }

    triggers{
        pollSCM('* * * * *')
    }

stages{
        stage('Build'){
            steps {
                sh 'mvn clean package'
            }
            post {
                success {
                    echo 'Now Archiving...'
                    archiveArtifacts artifacts: '**/target/*.war'
                }
            }
        }

        stage ('Deployments'){
            parallel{
                stage ('Deploy to Staging'){
                    steps {
                        sh "scp -i /home/nisum/Desktop/dev/tomcat-demo.pem **/target/*.war ec2-user@${params.tomcat_dev}:/var/lib/tomcat7/webapps"
                    }
                }
            }
        }
    }    
}