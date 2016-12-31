package lt.vilnius.tvarkau.infra;

import lt.vilnius.tvarkau.support.sparkext.ConditionalExceptionHandler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import spark.ExceptionHandler;
import spark.Request;
import spark.Response;

import javax.inject.Inject;
import javax.inject.Singleton;
import java.util.Set;

@Singleton
public class RootExceptionHandler implements ExceptionHandler {

    private static final Logger log = LoggerFactory.getLogger(RootExceptionHandler.class);
    private final Set<ConditionalExceptionHandler> delegates;
    private final InternalServerErrorHandler fallbackHandler;

    @Inject
    public RootExceptionHandler(Set<ConditionalExceptionHandler> delegates, InternalServerErrorHandler fallbackHandler) {
        this.delegates = delegates;
        this.fallbackHandler = fallbackHandler;
    }

    @Override
    public void handle(Exception exception, Request request, Response response) {
        log.error(exception.getMessage(), exception);
        delegates.stream()
            .filter(h -> h.canHandle(exception))
            .findAny()
            .orElse(fallbackHandler)
            .handle(exception, request, response);
    }

}
