# ── Stage 1: Build ────────────────────────────────────────────────────────────
FROM maven:3.9-eclipse-temurin-21-slim AS build
WORKDIR /app
# Cache dependencies layer separately (speeds up rebuilds)
COPY pom.xml .
RUN mvn dependency:go-offline -q
COPY src ./src
RUN mvn clean package -DskipTests -q

# ── Stage 2: Runtime (slim Tomcat only, no Maven) ─────────────────────────────
FROM tomcat:10.1-jdk21-temurin-jammy

# Remove default webapps to free memory & reduce startup scan time
RUN rm -rf /usr/local/tomcat/webapps/*

# Performance tuning: disable unused Tomcat connectors logging overhead
RUN sed -i 's/org.apache.juli.AsyncFileHandler/org.apache.juli.FileHandler/g' \
    /usr/local/tomcat/conf/logging.properties 2>/dev/null || true

# Copy built WAR
COPY --from=build /app/target/Study4Diploma.war /usr/local/tomcat/webapps/ROOT.war

# Tomcat JVM tuning for Render (free tier has ~512MB RAM)
ENV JAVA_OPTS="\
  -server \
  -Xms128m \
  -Xmx384m \
  -XX:+UseG1GC \
  -XX:MaxGCPauseMillis=200 \
  -XX:+UseStringDeduplication \
  -Djava.security.egd=file:/dev/./urandom \
  -Dfile.encoding=UTF-8"

EXPOSE 8080
CMD ["catalina.sh", "run"]
