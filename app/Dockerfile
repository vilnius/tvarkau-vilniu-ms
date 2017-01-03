FROM java:8-jre-alpine

RUN apk add --no-cache \
curl

ADD build/libs/*.jar /opt/tvarkau-vilniu/app.jar
WORKDIR /opt/tvarkau-vilniu

EXPOSE 8080
EXPOSE 5005

HEALTHCHECK --interval=10s --timeout=20s CMD curl --fail http://localhost:8080/health || exit 1

ENTRYPOINT exec java -server \
$DEBUG_OPTS \
$JAVA_OPTS \
-jar app.jar
