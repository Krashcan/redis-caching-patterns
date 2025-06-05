FROM eclipse-temurin:21-jdk-jammy

WORKDIR /app

COPY gradle/ gradle/
COPY gradlew build.gradle settings.gradle ./
RUN chmod +x ./gradlew
RUN ./gradlew dependencies

COPY src/ src/

RUN ./gradlew build -x test

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "build/libs/redis-caching-patterns-1.0-SNAPSHOT.jar"]