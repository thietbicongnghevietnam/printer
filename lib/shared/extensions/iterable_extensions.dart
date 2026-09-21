extension IterableExt<T> on Iterable<T> {
  List<T> clone() {
    return List.from(this);
  }

  int sumBy(int Function(T e) toElement) {
    return fold(
      0,
      (previousValue, element) => previousValue + toElement(element),
    );
  }

  List<T> copyWithReplace(T element, T replacement) {
    return [for (final e in this) e == element ? replacement : e];
  }

  List<T> leftOuterJoin(Iterable<T?> other) {
    final list = <T>[];
    forEach((element) {
      if (!other.contains(element)) {
        list.add(element);
      }
    });
    return list;
  }
}
