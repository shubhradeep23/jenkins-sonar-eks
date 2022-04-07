FROM openjdk:11-jre-alpine
COPY target/*.jar /myapp.jar
ENTRYPOINT ["java", "-jar", "myapp.jar"]
