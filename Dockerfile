FROM eclipse-temurin:21

COPY ./target/registry.jar /app.jar

ENTRYPOINT ["java", "-jar", "/app.jar"]
