package lt.vilnius.tvarkau.device

import org.dalesbred.Database

import static org.dalesbred.query.SqlQuery.namedQuery

class DeviceDao {

    private final Database db

    DeviceDao(Database db) {
        this.db = db
    }

    boolean exists(UUID uuid) {
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
