enum InOutType {
  oneByOne,
  all;

  @override
  String toString() {
    return switch (this) {
      oneByOne => 'One By One',
      all => 'All',
    };
  }
}
