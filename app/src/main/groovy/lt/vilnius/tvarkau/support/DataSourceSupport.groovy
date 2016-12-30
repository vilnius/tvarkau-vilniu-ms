package lt.vilnius.tvarkau.support

import com.zaxxer.hikari.HikariConfig
import com.zaxxer.hikari.HikariDataSource
import org.dalesbred.Database

import javax.sql.DataSource
import java.sql.Connection

class DataSourceSupport {

    static final DataSource dataSource
    static final Database database

    static {
        def hikariPoolConfig = new HikariConfig()
        hikariPoolConfig.with {
            jdbcUrl = Environment.datasourceUrl()
            username = Environment.datasourceUsername()
            password = Environment.datasourcePassword()
            registerMbeans = true
        }
        dataSource = new HikariDataSource(hikariPoolConfig)
        database = Database.forDataSource(dataSource)
    }

    static Connection getConnection() {
        return dataSource.getConnection()
    }

}
