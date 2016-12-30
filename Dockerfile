FROM java:8-jre-alpine
ADD app/build/libs/*.jar /opt/tvarkau-vilniu/app.jar
WORKDIR /opt/tvarkau-vilniu

EXPOSE 8080
EXPOSE 5005

ENTRYPOINT exec java -server \
$DEBUG_OPTS \
$JAVA_OPTS \
-jar app.jar
