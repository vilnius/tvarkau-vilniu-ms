FROM java:8-jre-alpine
ADD app/build/libs/*.jar /opt/tvarkau-vilniu/app.jar
WORKDIR /opt/tvarkau-vilniu

EXPOSE 8080

ENTRYPOINT exec java -server \
$JAVA_OPTS \
-jar app.jar
