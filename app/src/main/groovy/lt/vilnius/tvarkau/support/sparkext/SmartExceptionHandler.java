package lt.vilnius.tvarkau.support.sparkext;

import spark.Request;
import spark.Response;

public interface SmartExceptionHandler {

    boolean canHandle(Exception ex);

    void handle(Exception ex, Request req, Response res);

}
