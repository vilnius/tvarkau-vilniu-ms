package lt.vilnius.tvarkau.device

import lt.vilnius.tvarkau.Config
import lt.vilnius.tvarkau.support.DataSourceSupport
import spark.Request
import spark.Response

import static spark.Spark.put

class DeviceController {

    public static final String DEVICE_UUID_HEADER = 'x-device-uuid'
    private final DeviceDao dao

    DeviceController() {
        dao = new DeviceDao(DataSourceSupport.database)
        put('/device', this.&registerDevice, Config.JSON)
    }

    DeviceResource registerDevice(Request req, Response res) {
        UUID deviceUuid = deviceUuid(req) ?: UUID.randomUUID()
        if (!dao.exists(deviceUuid)) {
            def device = dao.insert(new Device(uuid: deviceUuid.toString()))
            return new DeviceResource(uuid: UUID.fromString(device.uuid))
        }
        return new DeviceResource(uuid: deviceUuid ?: UUID.randomUUID())
    }

    static UUID deviceUuid(Request req) {
        def header = req.headers(DEVICE_UUID_HEADER) as String
        return header?.with(UUID.&fromString) as UUID
    }

}
