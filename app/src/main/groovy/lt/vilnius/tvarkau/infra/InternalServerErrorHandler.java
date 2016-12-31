package lt.vilnius.tvarkau.infra;

import lt.vilnius.tvarkau.support.sparkext.ConditionalExceptionHandler;
import spark.Request;
import spark.Response;

import javax.inject.Inject;
import javax.inject.Singleton;

@Singleton
class InternalServerErrorHandler implements ConditionalExceptionHandler {

    @Inject
    public InternalServerErrorHandler() {
    }

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
