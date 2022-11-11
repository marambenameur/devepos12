pipeline {
    environment {
        registry = "saifhendili/mydevops"
        registryCredential = 'dockerHub'
        dockerImage = ''
    }
   agent any
   stages {
    stage('Git Checkout') {
      steps {
        echo 'pulling...';
         git branch:'saif',
         url : 'https://github.com/marambenameur/devepos12';
         }
        }
      stage('MVN CLEAN') {
            steps {
                sh 'mvn clean'
            }
        }
       
        stage('MVN COMPILE') {
            steps {
                sh 'mvn compile'
            }
        }
    stage("MVN SonarQube") {
      
       		steps {
        	  sh "mvn sonar:sonar \
  				-Dsonar.projectKey=socarqube \
  				-Dsonar.host.url=http://192.168.1.173:9000 \
  				-Dsonar.login=6e96b26c7adf6d429cc30258cf59c6aa8e33b666"
      	}
    }
            stage('Test mvn') {
            steps {
              sh """ mvn -DskipTests clean package """ 
                sh """ mvn install """;
  
            }
        }

    stage('Nexus') {
      steps {
        sh 'mvn clean deploy -Dmaven.test.skip=true'
      }
    }
        stage('MVN PACKAGE') {
            steps {
                sh 'mvn package -DskipTests'
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

     stage('Start container') {
             steps {
                sh 'docker-compose up -d '
      }
        }
       }
      }
     