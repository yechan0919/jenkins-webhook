# Stage 1: Build the application
FROM maven:3.6.3-jdk-11 AS builder

WORKDIR /usr/src/app

COPY . .

# Build the Maven project
RUN mvn clean package

# Stage 2: Copy the built artifact to Tomcat
FROM tomcat:9.0-jdk11-corretto

# Set the working directory
WORKDIR /usr/local/tomcat/webapps

# Copy the WAR file from the builder stage
COPY --from=builder /usr/src/app/target/jenkins.war ./ROOT.war

# Start Tomcat
CMD ["catalina.sh", "run"]