# Use an official Tomcat image as the base for deploying a Java Web App
FROM tomcat:10.1.36-jdk17-temurin

# Copy the WAR file from the local machine to Tomcat's webapps directory
COPY target/comp367-webapp-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/app.war

# Expose the port your application runs on (Tomcat default is 8080)
EXPOSE 8080

# Default command to start Tomcat.
CMD ["catalina.sh", "run"]
