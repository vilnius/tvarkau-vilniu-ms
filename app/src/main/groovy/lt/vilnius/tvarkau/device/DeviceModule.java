package lt.vilnius.tvarkau.device;

import dagger.Module;
import dagger.Provides;
import dagger.multibindings.IntoSet;
import lt.vilnius.tvarkau.support.sparkext.SelfRegisteringController;

@Module
public class DeviceModule {

    @Provides
    @IntoSet
    static SelfRegisteringController deviceController(DeviceRepository dao) {
        return new DeviceController(dao);
    }

}
