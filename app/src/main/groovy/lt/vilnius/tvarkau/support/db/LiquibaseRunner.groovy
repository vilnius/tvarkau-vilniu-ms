package lt.vilnius.tvarkau.support.db

import liquibase.Contexts
import liquibase.Liquibase
import liquibase.database.DatabaseFactory
import liquibase.database.jvm.JdbcConnection
import liquibase.resource.ClassLoaderResourceAccessor

import javax.inject.Inject
import javax.inject.Singleton
import javax.sql.DataSource
import java.sql.Connection

@Singleton
class LiquibaseRunner {

    private final DataSource dataSource

    @Inject
    LiquibaseRunner(DataSource dataSource) {
        this.dataSource = dataSource
    }

    void run() {
        Connection conn
        try {
            conn = dataSource.connection
            def database = DatabaseFactory.instance.findCorrectDatabaseImplementation(new JdbcConnection(conn))
            Liquibase liquibase = new Liquibase('db/changelog.xml', new ClassLoaderResourceAccessor(), database)
            liquibase.update(new Contexts())
        } finally {
            if (conn) {
                conn.close()
            }
        }
    }
}
