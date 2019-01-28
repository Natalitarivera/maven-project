pipeline { 
    agent any
    stages{
        stage('Build'){
            steps{
                sh 'mvn clean package'
                sh "docker build . -t tomcatwebapp:${env.BUILD_ID}"
            }
        }
        stage('Deploy'){
            steps{
                sh "docker run -d -p 8181:8080 tomcatwebapp:${env.BUILD_ID}"
            }
        }
    }
}