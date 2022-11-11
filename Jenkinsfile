pipeline {
environment {
        registry = "benzarty/devops"
        registryCredential = 'dockerHub'
        dockerImage = ''
    }
   agent any
   stages {
    stage('Git Checkout') {
      steps {
        echo 'pulling...';
         git branch:'main',
         url : 'https://github.com/marambenameur/devepos12';
         
         }
        }
    stage('testing maven') {
      steps {
        sh """mvn -version"""
         
         }
        }
    stage('Test mvn') {
            steps {
              sh """ mvn -DskipTests clean package """ 
                sh """ mvn install """;
                sh """ mvn test """;
            }
        }
        
        stage('JUNIT') {
            steps {
                sh 'mvn test'
            }
        }
    stage("MVN SonarQube") {
      
          steps {
            sh "mvn sonar:sonar \
              -Dsonar.projectKey=sonarr \
              -Dsonar.host.url=http://192.168.1.21:9000 \
              -Dsonar.login=c0280cbb5b01d38ab7c54356da951f9efd900486"
      }
    }
    stage('Building our image') {
            steps {
                script {
                    dockerImage = docker.build registry +":$BUILD_NUMBER"
                }
            }
        }
        stage('Deploy our image') {
            steps {
                script {
                    docker.withRegistry( '', registryCredential ) {
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Cleaning up') {
            steps {
                echo "docker rmi $registry:$BUILD_NUMBER "
                sh "docker rmi $registry:$BUILD_NUMBER "
        }
    }
    stage('Nexus') {
      steps {
        sh 'mvn clean deploy -Dmaven.test.skip=true'
      }
    }

    stage('Start container') {
             steps {
                sh 'docker-compose up -d '
      }
        }
   
       }
      }
        