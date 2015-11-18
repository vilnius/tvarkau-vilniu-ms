package lt.vilnius.tvarkau.common

public class UUIDUtils {

    static Optional<UUID> maybeUUID(String uuidString) {
        try {
            return Optional.of(UUID.fromString(uuidString))
        } catch (e) {
            return Optional.empty()
        }
    }
}
