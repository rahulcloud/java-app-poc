##FROM openjdk:10-jre-slim
FROM adoptopenjdk/openjdk11:alpine-slim

WORKDIR /app
COPY ./target/demo-0.0.1-SNAPSHOT.jar /app

EXPOSE 8090

CMD ["java", "-jar", "demo-0.0.1-SNAPSHOT.jar"]
