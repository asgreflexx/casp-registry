FROM openjdk:8-jdk-alpine
VOLUME /tmp
COPY target/casp-service-registry-0.0.1-SNAPSHOT.jar casp-service-registry-0.0.1-SNAPSHOT.jar
ENTRYPOINT ["java", "-jar", "/casp-service-registry-0.0.1-SNAPSHOT.jar"]