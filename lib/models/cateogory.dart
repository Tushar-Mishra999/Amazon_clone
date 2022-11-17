class Categories {
  final String title;
  final String? image;
  final String categoryId;
  Categories({required this.title, this.image,required this.categoryId});

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(title: json["category_name"], image: json["image"],categoryId: json["category_id"]);
  }
}
