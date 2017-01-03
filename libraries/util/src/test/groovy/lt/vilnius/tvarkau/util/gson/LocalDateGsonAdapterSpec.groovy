package lt.vilnius.tvarkau.util.gson

import com.google.gson.Gson
import com.google.gson.GsonBuilder
import groovy.json.JsonSlurper
import spock.lang.Shared
import spock.lang.Specification

import java.time.LocalDate

import static java.time.Month.MAY

class LocalDateGsonAdapterSpec extends Specification {

    @Shared
    Gson gson = new GsonBuilder()
        .registerTypeAdapter(LocalDate, new LocalDateGsonAdapter())
        .create()

    def 'serializes/deserializes local date'() {
        when:
            String json = gson.toJson(new DateHolder(
                localDate: LocalDate.of(1999, MAY, 20)
            ))
            Map parsedJson = new JsonSlurper().parseText(json) as Map
        then:
            parsedJson.localDate == '1999-05-20'

        when:
            DateHolder parsedDate = gson.fromJson(json, DateHolder)
        then:
            with(parsedDate.localDate) {
                year == 1999
                month == MAY
                dayOfMonth == 20
            }
    }

    static class DateHolder {
        LocalDate localDate
    }
}
