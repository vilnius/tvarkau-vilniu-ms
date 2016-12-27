package lt.vilnius.tvarkau

import com.google.gson.Gson
import spark.Filter
import spark.Request
import spark.Response
import spark.ResponseTransformer
import spark.Route

class Config {

    static final Gson GSON = new Gson()
    static final ResponseTransformer JSON = GSON.&toJson as ResponseTransformer

    static Filter defaultContentTypeFilter() {
        { Request req, Response res ->
            res.type('application/json')
        } as Filter
    }

    static Route route404() {
        { Request req, Response res ->
            res.body('{}')
            res.status(404)
        } as Route
    }
}
