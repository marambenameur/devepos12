FROM openjdk:8-jdk-alpine
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} devops.jar
ENTRYPOINT ["java","-jar","/devops.jar"]

