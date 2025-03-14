# Use the official Maven image for building the project
FROM maven:3.9.9-eclipse-temurin-17 as build

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the rest of the application source code
COPY src ./src

# Build the application
RUN mvn clean package

# Use a lightweight Tomcat image for deployment
FROM tomcat:10.1.16-jdk17-temurin

# Set the working directory inside the container
WORKDIR /usr/local/tomcat/webapps/

# Copy the WAR file built by Maven into Tomcat's webapps folder
#COPY --from=build /app/target/jenkins-maven-lab2-web-app-0.0.1-SNAPSHOT.war ROOT.war
COPY --from=build /app/target/comp367-webapp-0.0.1-SNAPSHOT.war ROOT.war


# Expose port 8080
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
