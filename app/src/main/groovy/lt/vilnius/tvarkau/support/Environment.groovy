package lt.vilnius.tvarkau.support

class Environment {

    static String dbHost() {
        System.getenv('DB_HOST') ?: 'localhost'
    }

    static String dbPort() {
        System.getenv('DB_PORT') ?: '5432'
    }

    static String dbName() {
        System.getenv('DB_NAME') ?: 'tvarkauvilniu'
    }

    static String dbUsername() {
        System.getenv('DB_USERNAME') ?: 'tvarkauvilniu'
    }

    static String dbPassword() {
        System.getenv('DB_PASSWORD') ?: 'tvarkauvilniu'
    }

}
