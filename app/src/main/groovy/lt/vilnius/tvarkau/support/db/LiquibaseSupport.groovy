package lt.vilnius.tvarkau.support.db

import liquibase.Contexts
import liquibase.Liquibase
import liquibase.database.DatabaseFactory
import liquibase.database.jvm.JdbcConnection
import liquibase.resource.ClassLoaderResourceAccessor
import lt.vilnius.tvarkau.support.db.DatabaseSupport

import java.sql.Connection

class LiquibaseSupport {

    static void run() {
        Connection conn
        Liquibase liquibase
        try {
            conn = DatabaseSupport.getConnection()
            def database = DatabaseFactory.instance.findCorrectDatabaseImplementation(new JdbcConnection(conn))
            liquibase = new Liquibase('db/changelog.xml', new ClassLoaderResourceAccessor(), database)
            liquibase.update(new Contexts())
        } finally {
            if (conn) {
                conn.close()
            }
        }
    }
}