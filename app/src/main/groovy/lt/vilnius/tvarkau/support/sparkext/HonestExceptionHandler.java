package lt.vilnius.tvarkau.support.sparkext;

import spark.ExceptionHandler;
import spark.Request;
import spark.Response;

/**
 * Handler that tells if it can handle the given exception
 * before the actual {@link #handle(Exception, Request, Response)} call.
 */
public interface HonestExceptionHandler extends ExceptionHandler {

    boolean canHandle(Exception ex);

}
