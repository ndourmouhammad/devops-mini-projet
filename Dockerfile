# Utilisation d'une image stable et maintenue (Java 17 pour matcher votre build Maven)
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# On copie précisément le JAR généré par Maven
COPY target/devops-mini-projet-1.0-SNAPSHOT.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]