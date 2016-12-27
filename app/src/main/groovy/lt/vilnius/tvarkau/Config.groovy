package lt.vilnius.tvarkau

import com.google.gson.Gson
import com.google.gson.GsonBuilder
import lt.vilnius.tvarkau.util.LocalDateGsonAdapter
import spark.*

import java.time.LocalDate

class Config {

    static final Gson GSON = new GsonBuilder()
        .registerTypeAdapter(LocalDate, new LocalDateGsonAdapter())
        .setPrettyPrinting()
        .create()

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
