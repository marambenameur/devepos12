pipeline {
	environment {
        registry = "mounaayed/devopss"
        registryCredential = 'dockerHub'
        dockerImage = ''
    }
   agent any
   stages {
    stage('Git Checkout') {
      steps {
        echo 'pulling...';
         git branch:'mouna',
         url : 'https://github.com/marambenameur/devepos12';
         
         }
        }
   
    stage('Test mvn') {
            steps {
              sh """ mvn -DskipTests clean package """ 
               sh """ mvn clean """;
                sh """ mvn install """;
                sh """ mvn test """;
            }
        }
        stage('JUNIT/MOCKITO') {
            steps {
                sh 'mvn test'
            }
        }
        stage('MVN PACKAGE') {
            steps {
                sh 'mvn package -DskipTests'
            }
        }
        stage("MVN SonarQube") {
      
       		steps {
        	  sh "mvn sonar:sonar \
  -Dsonar.projectKey=sonarfinal \
  -Dsonar.host.url=http://192.168.1.21:9000 \
  -Dsonar.login=3008fd10509bf973af5f69afab760783fa98aa5d"
      	}
    }
    stage('Nexus') {
      steps {
        sh 'mvn clean deploy -Dmaven.test.skip=true'
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
     stage('Docker Login'){
            steps{
            echo "login"
               //sh 'docker login -u mounaayed -p "Twiin2021"'
            }
     } 
    
     stage('Start container') {
             steps {
                sh 'docker-compose up -d '
      }
        }
     
       }
      }