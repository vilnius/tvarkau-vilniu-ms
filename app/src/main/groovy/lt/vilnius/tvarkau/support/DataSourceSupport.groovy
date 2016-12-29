package lt.vilnius.tvarkau.support

import com.zaxxer.hikari.HikariConfig
import com.zaxxer.hikari.HikariDataSource

import javax.sql.DataSource
import java.sql.Connection

class DataSourceSupport {

    static DataSource dataSource

    static {
        def hikariPoolConfig = new HikariConfig()
        hikariPoolConfig.with {
            jdbcUrl = Environment.datasourceUrl()
            username = Environment.datasourceUsername()
            password = Environment.datasourcePassword()
            registerMbeans = true
        }
        dataSource = new HikariDataSource(hikariPoolConfig)
    }

    static Connection getConnection() {
        return dataSource.getConnection()
    }

}
