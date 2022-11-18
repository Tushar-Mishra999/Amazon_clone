class Categories {
  final String title;
  final String? image;
  final String categoryId;
  String? images;
  Categories({required this.title, this.image,required this.categoryId,this.images});

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(title: json["category_name"], image: json["image"],categoryId: json["category_id"]);
  }
}
