# Multi-stage build for Spring Legacy application
FROM gradle:8-jdk21 AS build

# Set working directory
WORKDIR /app

# Copy gradle files
COPY build.gradle settings.gradle ./
COPY gradle/ ./gradle/

# Copy source code
COPY src/ ./src/

# Build the application
RUN gradle clean build -x test

# Runtime stage with Tomcat
FROM tomcat:10-jdk21

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy built war file from build stage
COPY --from=build /app/build/libs/*.war /usr/local/tomcat/webapps/ROOT.war

# Create logs directory
RUN mkdir -p /usr/local/tomcat/logs

# Expose port 8080
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=60s --retries=3 \
  CMD curl -f http://localhost:8080/ || exit 1

# Start Tomcat
CMD ["catalina.sh", "run"]