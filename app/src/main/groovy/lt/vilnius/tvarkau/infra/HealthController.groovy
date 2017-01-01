package lt.vilnius.tvarkau.infra

import lt.vilnius.tvarkau.Config
import lt.vilnius.tvarkau.support.sparkext.SelfRegisteringController
import spark.Request
import spark.Response
import spark.Spark

import javax.inject.Singleton

@Singleton
class HealthController implements SelfRegisteringController {

    @Override
    void register() {
        Spark.get('/health', this.&health, Config.JSON)
    }

    private HealthInfo health(Request req, Response res) {
        new HealthInfo(status: 'OK')
    }

    static class HealthInfo {
        String status
    }

}
