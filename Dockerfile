FROM openjdk:10-jre-slim

WORKDIR /app
COPY ./target/<your-file>-<version>/SNAPSHOT.jar /app

EXPOSE 8080

CMD ["java", "-jar", "<your-file>-<version>/SNAPSHOT.jar"]
