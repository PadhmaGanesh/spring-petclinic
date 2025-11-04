<<<<<<< HEAD
# ---- Build stage ----
FROM eclipse-temurin:25-jdk AS build

RUN apt-get update && apt-get install -y maven git && rm -rf /var/lib/apt/lists/*

WORKDIR /app
ADD . /app

RUN mvn clean package -DskipTests

# ---- Runtime stage ----
FROM eclipse-temurin:25-jre AS runtime

# Add a normal user (portable version)
RUN useradd -m -d /usr/share/demo -s /bin/bash testuser

USER testuser
WORKDIR /usr/share/demo

COPY --from=build /app/target/*.jar app.jar

=======
FROM maven:3.9.11-eclipse-temurin-17 AS build
ADD git clone https://github.com/PadhmaGanesh/spring-petclinic.git /javaapp
WORKDIR /javapp
RUN mvn package

FROM eclipse-temurin:17.0.16_8-jre-ubi9-minimal AS runtime
COPY --from=build /javaapp/target/*.jar ganesh.jar
>>>>>>> 006e508a06c87286d2779f666a9e0218267f7812
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]

