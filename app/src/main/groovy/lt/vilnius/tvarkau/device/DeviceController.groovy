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

    DeviceResource registerDevice(Request req, Response res) {
        UUID deviceUuid = deviceUuid(req) ?: UUID.randomUUID()
        if (!repository.exists(deviceUuid)) {
            def device = repository.insert(new Device(uuid: deviceUuid.toString()))
            return new DeviceResource(uuid: UUID.fromString(device.uuid))
        }
        return new DeviceResource(uuid: deviceUuid ?: UUID.randomUUID())
    }

    static UUID deviceUuid(Request req) {
        def header = req.headers(DEVICE_UUID_HEADER) as String
        return header?.with(UUID.&fromString) as UUID
    }

}
