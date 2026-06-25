# Usamos una imagen base de Java
FROM eclipse-temurin:21-jdk-alpine

# Directorio de trabajo
WORKDIR /app

# Copiamos el archivo JAR compilado por Maven
# (Asegúrate de ejecutar './mvnw clean package' antes de construir la imagen localmente)
COPY target/*.jar app.jar

# Exponemos el puerto
EXPOSE 8080

# Comando para ejecutar la app
ENTRYPOINT ["java", "-jar", "app.jar"]