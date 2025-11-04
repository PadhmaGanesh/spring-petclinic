FROM maven:3.9.11-eclipse-temurin-17 AS build
ADD git clone https://github.com/PadhmaGanesh/spring-petclinic.git /javaapp
WORKDIR /javapp
RUN mvn package

FROM eclipse-temurin:17.0.16_8-jre-ubi9-minimal AS runtime
COPY --from=build /javaapp/target/*.jar ganesh.jar
EXPOSE 8080
CMD ["java","-jar","ganesh.jar"]
