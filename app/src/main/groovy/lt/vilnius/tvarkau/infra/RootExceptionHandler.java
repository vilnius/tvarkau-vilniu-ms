package lt.vilnius.tvarkau.infra;

import lt.vilnius.tvarkau.support.db.DatabaseSQLExceptionHandler;
import lt.vilnius.tvarkau.support.sparkext.HonestExceptionHandler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import spark.ExceptionHandler;
import spark.Request;
import spark.Response;

import java.util.ArrayList;
import java.util.List;

public class RootExceptionHandler implements ExceptionHandler {

    private static final Logger log = LoggerFactory.getLogger(RootExceptionHandler.class);
    private static final HonestExceptionHandler FALLBACK_HANDLER = new InternalServerErrorHandler();
    private final List<HonestExceptionHandler> delegates = new ArrayList<>();

    {
        delegates.add(new DatabaseSQLExceptionHandler());
    }

    @Override
    public void handle(Exception exception, Request request, Response response) {
        log.error(exception.getMessage(), exception);
        delegates.stream()
            .filter(h -> h.canHandle(exception))
            .findAny()
            .orElse(FALLBACK_HANDLER)
            .handle(exception, request, response);
    }

}
