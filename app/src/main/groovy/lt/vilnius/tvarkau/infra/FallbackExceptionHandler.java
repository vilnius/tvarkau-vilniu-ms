package lt.vilnius.tvarkau.infra;

import lt.vilnius.tvarkau.support.sparkext.SmartExceptionHandler;
import spark.Request;
import spark.Response;

class FallbackExceptionHandler implements SmartExceptionHandler {

    @Override
    public boolean canHandle(Exception ex) {
        return true;
    }

    @Override
    public void handle(Exception exception, Request request, Response response) {
        response.body("{}");
        response.status(500);
    }
}
