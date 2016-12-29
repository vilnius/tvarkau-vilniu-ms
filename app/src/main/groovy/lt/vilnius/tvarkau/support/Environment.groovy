package lt.vilnius.tvarkau.support

class Environment {

    static String datasourceUrl() {
        System.getProperty('DS_URL') ?: 'jdbc:postgresql://localhost:5432/tvarkauvilniu'
    }

    static String datasourceUsername() {
        System.getProperty('DS_USERNAME') ?: 'tvarkauvilniu'
    }

    static String datasourcePassword() {
        System.getProperty('DS_PASSWORD') ?: 'tvarkauvilniu'
    }

}
