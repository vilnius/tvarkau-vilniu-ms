package lt.vilnius.tvarkau.support.db;

import lt.vilnius.tvarkau.support.sparkext.ConditionalExceptionHandler;
import org.dalesbred.DatabaseSQLException;
import spark.Request;
import spark.Response;

import javax.inject.Singleton;
import java.sql.SQLException;

@Singleton
public class DatabaseSQLExceptionHandler implements ConditionalExceptionHandler {

    private static final String SQLCLIENT_UNABLE_TO_ESTABLISH_SQLCONNECTION = "08001";

    @Override
    public boolean canHandle(Exception e) {
        return e instanceof DatabaseSQLException &&
            (e.getCause() instanceof SQLException) &&
            SQLCLIENT_UNABLE_TO_ESTABLISH_SQLCONNECTION.equals(((SQLException) e.getCause()).getSQLState());
    }

    @Override
    public void handle(Exception exception, Request request, Response response) {
        response.body("{}");
        response.status(503);
    }
}
