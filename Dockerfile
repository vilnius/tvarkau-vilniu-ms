FROM java:8-jre

COPY . /opt/tvarkau-vilniu

EXPOSE 8080

WORKDIR /opt/tvarkau-vilniu

RUN chmod +x gradlew

RUN ["./gradlew", "build"]

ENTRYPOINT ["./gradlew", "run"]
