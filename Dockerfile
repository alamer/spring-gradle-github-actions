FROM gradle:6.3.0-jdk11 AS build
# Create and choose a workdir
RUN mkdir /home/gradle/project
WORKDIR /home/gradle/project
# Copy pom.xml to get dependencies
COPY build.gradle settings.gradle ./
# Copy sources
COPY src src
# Build app (jar will be in /usr/src/app/target/)
RUN gradle build

FROM openjdk:11-jre-slim
COPY --from=build /home/gradle/project/build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]