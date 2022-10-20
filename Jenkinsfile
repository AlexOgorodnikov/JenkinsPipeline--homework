  pipeline {
    
    agent any

      stages {       
          stage('Package build') {
              agent {
                  docker {
                      image "130.193.51.9:8123/test"
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
                  sh "docker build -t 130.193.51.9:8123/webapp ."
                  sh "docker push 130.193.51.9:8123/webapp"
          }
      }
          stage('Deploy app') {
              agent {
                docker{
                    image "130.193.51.9:8123/webapp"
                    registryUrl 'https://130.193.51.9:8123/'
                    registryCredentialsId 'c151739a-e97d-4fac-8f09-a65b99e99595'
                }
              }
            steps {
                node('tom'){ 
                  sh "docker pull 130.193.51.9:8123/webapp"
                  sh "docker run -p 80:8080 -d --name boxfuse 130.193.51.9:8123/webapp"
            }  
      }
  }
}
  }