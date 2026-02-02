FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# Utilisation du joker * pour copier le jar sans se soucier de la version exacte
COPY target/devops-mini-projet-*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]