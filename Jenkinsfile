pipeline {
    agent any
    parameters {
        string(name: 'tomcat_dev', defaultValue: '3.16.138.0', description: 'Staging Server')
        string(name: 'tomcat_prod', defaultValue: '18.216.15.123', description: 'Production Server' )
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
                        //withCredentials([sshUserPrivateKey(credentialsId: '8b29bd13-89ea-4395-86f4-d92c14930af5', keyFileVariable: 'a.pem', passphraseVariable: '', usernameVariable: '')]) {
                        sh "scp -i /home/nisum/Desktop/dev/tomcat-demo.pem -o StrictHostKeyChecking=no **/target/*.war ec2-user@${params.tomcat_dev}:/var/lib/tomcat7/webapps"
                    }
                }

                stage ('Deploy to Production'){
                    steps {
                        //withCredentials([sshUserPrivateKey(credentialsId: '8b29bd13-89ea-4395-86f4-d92c14930af5', keyFileVariable: 'a.pem', passphraseVariable: '', usernameVariable: '')]) {
                        sh "scp -i /home/nisum/Desktop/dev/tomcat-demo.pem -o StrictHostKeyChecking=no **/target/*.war ec2-user@${params.tomcat_prod}:/var/lib/tomcat7/webapps"
                    }
                }
            }
        }
    }    
}