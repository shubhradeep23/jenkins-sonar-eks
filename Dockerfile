FROM lolhens/baseimage-openjre
COPY . .
EXPOSE 80
ENTRYPOINT ["java", "-jar", "springbootApp.jar"]
