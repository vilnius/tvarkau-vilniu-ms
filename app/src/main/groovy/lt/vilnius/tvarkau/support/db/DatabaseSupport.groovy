package lt.vilnius.tvarkau.support.db

import com.zaxxer.hikari.HikariConfig
import com.zaxxer.hikari.HikariDataSource
import lt.vilnius.tvarkau.support.Environment
import org.dalesbred.Database
import org.dalesbred.connection.DataSourceConnectionProvider
import org.dalesbred.dialect.PostgreSQLDialect
import org.postgresql.ds.PGSimpleDataSource

import javax.sql.DataSource
import java.sql.Connection

class DatabaseSupport {

    static final DataSource dataSource
    static final Database database

    static {
        def hikariPoolConfig = new HikariConfig()
        hikariPoolConfig.with {
            dataSourceClassName = PGSimpleDataSource.class.name
            dataSourceProperties.setProperty('user', Environment.dbUsername())
            dataSourceProperties.setProperty('password', Environment.dbPassword())
            dataSourceProperties.setProperty('serverName', Environment.dbHost())
            dataSourceProperties.setProperty('portNumber', Environment.dbPort())
            dataSourceProperties.setProperty('databaseName', Environment.dbName())
            connectionTimeout = 5000
            registerMbeans = true
            initializationFailFast = false
        }
        dataSource = new HikariDataSource(hikariPoolConfig)
        database = new Database(new DataSourceConnectionProvider(dataSource), new PostgreSQLDialect())
    }

    static Connection getConnection() {
        return dataSource.getConnection()
    }

}
