package lt.vilnius.tvarkau;

import lt.vilnius.tvarkau.support.sparkext.SelfRegisteringController;

import java.io.BufferedReader;
import java.io.InputStreamReader;

import static spark.Spark.*;

class App {

    private static ContextComponent appContext;

    public static void main(String[] args) {
        printBanner();
        configure();
        startWebServer();
    }

    private static void printBanner() {
        new BufferedReader(new InputStreamReader(App.class.getResourceAsStream("/banner.txt")))
            .lines()
            .forEach(System.out::println);
    }

    private static void configure() {
        appContext = DaggerContextComponent.create();
        appContext.liquibaseRunner().run();
    }

    private static void startWebServer() {
        port(8080);
        after((req, res) -> res.type("application/json"));
        exception(Exception.class, appContext.rootExceptionHandler());
        appContext.controllers().forEach(SelfRegisteringController::register);
        notFound((req, res) -> "");
    }

}
