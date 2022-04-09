FROM openjdk:11

ARG JAR_FILE=target/*.jar
#ARG JAR_LIB_FILE=target/lib/

# cd /usr/local/runme
#WORKDIR /usr/local/runme
WORKDIR /opt
# copy target/find-links.jar /usr/local/runme/app.jar
COPY ${JAR_FILE} app.jar

# copy project dependencies
# cp -rf target/lib/  /usr/local/runme/lib
#ADD ${JAR_LIB_FILE} lib/

# java -jar /usr/local/runme/app.jar
CMD ["java","-jar","app.jar"]