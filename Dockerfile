FROM openjdk:11
COPY *.jar /myapp.jar
ENTRYPOINT ["java", "-jar", "myapp.jar"]
