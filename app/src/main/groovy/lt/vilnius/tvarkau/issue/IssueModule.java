package lt.vilnius.tvarkau.issue;

import dagger.Module;
import dagger.Provides;
import dagger.multibindings.IntoSet;
import lt.vilnius.tvarkau.support.sparkext.SelfRegisteringController;

@Module
public class IssueModule {

    @Provides
    @IntoSet
    SelfRegisteringController issueController() {
        return new IssueController();
    }

}
