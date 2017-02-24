package lt.vilnius.tvarkau.device

import lt.vilnius.tvarkau.Config
import lt.vilnius.tvarkau.support.sparkext.SelfRegisteringController
import spark.Request
import spark.Response

import javax.inject.Inject
import javax.inject.Singleton

import static spark.Spark.put

@Singleton
class DeviceController implements SelfRegisteringController {

    public static final String DEVICE_UUID_HEADER = 'x-device-uuid'
    private final DeviceRepository repository

    @Inject
    DeviceController(DeviceRepository repository) {
        this.repository = repository
    }

    @Override
    void register() {
        put('/device', this.&registerDevice, Config.JSON)
    }

    Device registerDevice(Request req, Response res) {
        def device = new Device(uuid: deviceUuidFromHeader(req) as String)
        return repository.exists(device.uuid) ?
            device : repository.insert(device)
    }

    static UUID deviceUuidFromHeader(Request req) {
        def header = req.headers(DEVICE_UUID_HEADER) as String
        return header?.with(UUID.&fromString) as UUID ?: UUID.randomUUID()
    }

}
