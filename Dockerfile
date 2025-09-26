FROM openjdk:21

COPY ./target/registry.jar /app.jar

ENTRYPOINT ["/usr/bin/java", "-jar", "/app.jar"]
