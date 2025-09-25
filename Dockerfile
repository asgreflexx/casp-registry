FROM openjdk:21

RUN groupadd -r nonroot && useradd -r -g nonroot nonroot

USER nonroot

COPY ./target/registry.jar /app.jar

ENTRYPOINT ["/usr/bin/java", "-jar", "/app.jar"]
