FROM openjdk

RUN touch /logback.xml

COPY ./target/registry.jar /registry.jar

ENTRYPOINT ["/usr/bin/java", "$JAVA_OPTS", "-Dlogging.config=file:/logback.xml", "-jar", "/registry.jar"]
