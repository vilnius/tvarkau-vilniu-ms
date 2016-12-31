package lt.vilnius.tvarkau.user;

import dagger.Module;
import dagger.Provides;
import dagger.multibindings.IntoSet;
import lt.vilnius.tvarkau.support.sparkext.SelfRegisteringController;

@Module
public class UserModule {

    @Provides
    @IntoSet
    SelfRegisteringController userController() {
        return new UserController();
    }

}
