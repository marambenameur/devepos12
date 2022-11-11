FROM openjdk:8-jdk-alpine
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} devopss.jar
ENTRYPOINT ["java","-jar","/devopss.jar"]
