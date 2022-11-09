FROM openjdk:8
ADD target/tpAchatProject-1.0.jar achatmaram.jar
EXPOSE 8089
ENTRYPOINT ["java", "-jar", "achatmaram.jar"]