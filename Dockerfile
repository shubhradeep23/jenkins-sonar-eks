FROM openjdk:8-jdk-alpine


ARG JAR_LIB_FILE=target/lib/

# cd /usr/local/runme
#WORKDIR /usr/local/runme

# copy target/find-links.jar /usr/local/runme/app.jar
COPY  /var/lib/jenkins/workspace/deploy-java-k8s@2/target/*.jar /usr/local/runme/app.jar

# copy project dependencies
# cp -rf target/lib/  /usr/local/runme/lib
ADD ${JAR_LIB_FILE} lib/

# java -jar /usr/local/runme/app.jar
ENTRYPOINT ["java","-jar","/usr/local/runme/app.jar"]