FROM openjdk:11-jdk-slim AS build
WORKDIR /gradle
COPY . /gradle/
RUN ./gradlew build

FROM openjdk:11-jre-slim
COPY --from=build /gradle/build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]