FROM openjdk:11
EXPOSE 8083
ADD target/petclinic.war petclinic.war
ENTRYPOINT ["java", "-jar", "/petclinic.war"]
