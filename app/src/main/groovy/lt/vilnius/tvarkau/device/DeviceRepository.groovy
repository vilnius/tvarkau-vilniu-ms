package lt.vilnius.tvarkau.device

import org.dalesbred.Database

import javax.inject.Inject
import javax.inject.Singleton

import static org.dalesbred.query.SqlQuery.namedQuery

@Singleton
class DeviceRepository {

    private final Database db

    @Inject
    DeviceRepository(Database db) {
        this.db = db
    }

    boolean exists(String uuid) {
        return db.findUniqueInt(
            'SELECT COUNT (1) FROM devices WHERE uuid = ?', uuid.toString()
        ) > 0
    }

    Device insert(Device device) {
        return db.findUnique(Device,
            namedQuery('INSERT INTO devices (uuid) VALUES (:uuid) RETURNING *', device)
        )
    }

}
