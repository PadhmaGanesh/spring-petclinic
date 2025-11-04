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

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]

