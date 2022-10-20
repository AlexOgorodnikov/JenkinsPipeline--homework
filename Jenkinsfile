  pipeline {
    
    agent any

      stages {       
          stage('Package build') {
              agent {
                  docker {
                      image "130.193.51.9:8123/jpipe"
                      registryUrl 'https://130.193.51.9:8123/'
                      registryCredentialsId 'c151739a-e97d-4fac-8f09-a65b99e99595'
                      args '-v /var/run/docker.sock:/var/run/docker.sock'
                  }
              }
              steps {
                  git 'https://github.com/AlexOgorodnikov/Java-app.git'
                  sh "mvn package"
                  sh "echo FROM tomcat:9.0.67-jdk11-temurin-jammy > Dockerfile"
                  sh "echo WORKDIR /usr/local/tomcat/webapps >> Dockerfile"
                  sh "echo COPY ./target/*.war /usr/local/tomcat/webapps >> Dockerfile"
                  sh "docker build -t 130.193.51.9:8123/webapp:1.0 ."
                  sh "docker push 130.193.51.9:8123/webapp:1.0"
                  sh "docker rmi 130.193.51.9:8123:8123/webapp:1.0"
          }
      }
          stage('Deploy app') {
              steps {
                  sshagent(['074e64ce-eccc-468e-812a-f7ce2e8884a0']) {
                  sh "ssh -o StrictHostKeyChecking=no -l root 178.154.204.120 docker pull 130.193.51.9:8123/webapp:1.0 ."
                  sh "ssh -o StrictHostKeyChecking=no -l root 178.154.204.120 docker run -p 80:8080 -d --name boxfuse 130.193.51.9:8123/webapp:1.0"
              }    
          }
      }
  }
}