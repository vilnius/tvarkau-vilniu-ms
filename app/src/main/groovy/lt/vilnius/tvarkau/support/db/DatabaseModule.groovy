package lt.vilnius.tvarkau.support.db

import com.zaxxer.hikari.HikariConfig
import com.zaxxer.hikari.HikariDataSource
import dagger.Module
import dagger.Provides
import dagger.multibindings.IntoSet
import lt.vilnius.tvarkau.support.Environment
import lt.vilnius.tvarkau.support.sparkext.ConditionalExceptionHandler
import org.dalesbred.Database
import org.dalesbred.connection.DataSourceConnectionProvider
import org.dalesbred.dialect.PostgreSQLDialect
import org.postgresql.ds.PGSimpleDataSource

import javax.inject.Singleton
import javax.sql.DataSource

@Module
class DatabaseModule {

    @Provides
    @Singleton
    static Database provideDatabase(DataSource dataSource) {
        return new Database(new DataSourceConnectionProvider(dataSource), new PostgreSQLDialect())
    }

    @Provides
    @Singleton
    static DataSource provideDataSource() {
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
        return new HikariDataSource(hikariPoolConfig)
    }

    @Provides
    @IntoSet
    static ConditionalExceptionHandler databaseSqlExceptionHandler() {
        return new DatabaseSQLExceptionHandler()
    }

}
