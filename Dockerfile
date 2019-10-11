FROM openjdk:8-jdk-alpine
ENV EUREKA_HOSTNAME="service-registry"
ENV EUREKA_PORT="8888"
ENV DB_HOSTNAME="10.0.5.1"
ENV DB_PORT="3306"
VOLUME /tmp
COPY target/casp-service-registry-0.0.1-SNAPSHOT.jar casp-service-registry-0.0.1-SNAPSHOT.jar
ENTRYPOINT ["java", "-jar", "/casp-service-registry-0.0.1-SNAPSHOT.jar"]