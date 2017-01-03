package lt.vilnius.tvarkau

import com.google.gson.Gson
import com.google.gson.GsonBuilder
import lt.vilnius.tvarkau.util.gson.LocalDateGsonAdapter
import spark.ResponseTransformer

import java.time.LocalDate

class Config {

    static final Gson GSON = new GsonBuilder()
        .registerTypeAdapter(LocalDate, new LocalDateGsonAdapter())
        .setPrettyPrinting()
        .create()

    static final ResponseTransformer JSON = GSON.&toJson as ResponseTransformer

}
