class PlantCategory {
  PlantCategory({
    this.plant,
    this.categoryList = const [],
  });

  final String? plant;
  final List<CategorySloc> categoryList;
}

class CategorySloc {
  CategorySloc({
    this.category,
    this.sloc = const [],
  });

  final String? category;
  final List<String> sloc;

  CategorySloc copyWith({
    String? cate,
  }) {
    return CategorySloc(
      category: cate,
      sloc: sloc,
    );
  }
}
