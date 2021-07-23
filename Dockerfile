FROM maven:3.5.2-jdk-8-alpine AS MAVEN_BUILD

WORKDIR /build/

COPY pom.xml ./
COPY src ./src/

RUN mvn clean install; 

FROM openjdk:8-jre-alpine

WORKDIR /app

ARG version=${version}

COPY --from=MAVEN_BUILD /build/target/consulti-$version.jar /app/app.jar

EXPOSE 5000

ENTRYPOINT ["java", "-jar", "app.jar"];