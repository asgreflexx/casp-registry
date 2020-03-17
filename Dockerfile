FROM openjdk:8-jdk-alpine
ENV EUREKA_HOSTNAME="localhost"
ENV EUREKA_PORT="19990"
COPY target/casp-registry-service.jar casp-registry-service.jar
ENTRYPOINT ["java", "-jar", "/casp-registry-service.jar"]
