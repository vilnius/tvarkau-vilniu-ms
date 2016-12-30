package lt.vilnius.tvarkau;

import lt.vilnius.tvarkau.device.DeviceController;
import lt.vilnius.tvarkau.infra.RootExceptionHandler;
import lt.vilnius.tvarkau.issue.IssueController;
import lt.vilnius.tvarkau.support.db.DatabaseSupport;
import lt.vilnius.tvarkau.support.db.LiquibaseSupport;
import lt.vilnius.tvarkau.user.UserController;

import java.io.BufferedReader;
import java.io.InputStreamReader;

import static spark.Spark.*;

class App {

    static void main(String[] args) {
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
        new DatabaseSupport();
        LiquibaseSupport.run();
    }

    private static void startWebServer() {
        port(8080);
        after(Config.defaultContentTypeFilter());
        registerControllers();
        exception(Exception.class, new RootExceptionHandler());
        notFound((req, res) -> "");
    }

    private static void registerControllers() {
        new DeviceController();
        new UserController();
        new IssueController();
    }
}
