package lt.vilnius.tvarkau;

import dagger.Component;
import lt.vilnius.tvarkau.device.DeviceModule;
import lt.vilnius.tvarkau.infra.RootExceptionHandler;
import lt.vilnius.tvarkau.issue.IssueModule;
import lt.vilnius.tvarkau.support.db.DatabaseModule;
import lt.vilnius.tvarkau.support.db.LiquibaseRunner;
import lt.vilnius.tvarkau.support.sparkext.SelfRegisteringController;
import lt.vilnius.tvarkau.user.UserModule;

import javax.inject.Singleton;
import java.util.Set;

@Singleton
@Component(modules = {
    DatabaseModule.class,
    DeviceModule.class,
    IssueModule.class,
    UserModule.class
})
interface ContextComponent {

    LiquibaseRunner liquibaseRunner();

    Set<SelfRegisteringController> controllers();

    RootExceptionHandler rootExceptionHandler();

}
