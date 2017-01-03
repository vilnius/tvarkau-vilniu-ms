package lt.vilnius.tvarkau.util.hypermedia

class CollectionResource<T> {
    final List<T> entries

    CollectionResource(List<T> entries) {
        this.entries = new ArrayList(entries)
    }
}
