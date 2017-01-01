package lt.vilnius.tvarkau.infra;

import dagger.Module;
import dagger.Provides;
import dagger.multibindings.IntoSet;
import lt.vilnius.tvarkau.support.sparkext.SelfRegisteringController;

@Module
public class InfrastructureModule {

    @Provides
    @IntoSet
    SelfRegisteringController healthController() {
        return new HealthController();
    }

}
