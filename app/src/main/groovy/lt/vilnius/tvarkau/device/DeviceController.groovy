package lt.vilnius.tvarkau.device

import lt.vilnius.tvarkau.Config
import spark.Request
import spark.Response

import static spark.Spark.put

class DeviceController {

    public static final String DEVICE_UUID_HEADER = 'x-device-uuid'

    DeviceController() {
        put('/device', this.&registerDevice, Config.JSON)
    }

    DeviceResource registerDevice(Request req, Response res) {
        UUID deviceUuid = deviceUuid(req)
        new DeviceResource(uuid: deviceUuid ?: UUID.randomUUID())
    }

    static UUID deviceUuid(Request req) {
        UUID.fromString(req.attribute(DEVICE_UUID_HEADER) as String)
    }

}
