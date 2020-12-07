FROM openjdk
COPY ./target/registry.jar /registry.jar
ENTRYPOINT ["/usr/bin/java", "-jar", "/registry.jar"]
