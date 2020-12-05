FROM openjdk
COPY ./target/registry.jar /registry.jar
ENTRYPOINT ["java", "-jar", "/registry.jar"]
