# ── Stage 1: Build ────────────────────────────────────────────────────────────
FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /app
# Cache dependencies layer separately (speeds up rebuilds)
COPY pom.xml .
RUN mvn dependency:go-offline -q
COPY src ./src
RUN mvn clean package -DskipTests -q

# ── Stage 2: Runtime ──────────────────────────────────────────────────────────
FROM tomcat:10.1-jdk21-temurin

# Remove default webapps to free memory & reduce startup scan time
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy built WAR
COPY --from=build /app/target/Study4Diploma.war /usr/local/tomcat/webapps/ROOT.war

# Tomcat JVM tuning for Render free tier
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