class Sales {
  final String label;
  final int earning;

  Sales({required this.label,this.earning=0});
  factory Sales.fromMap(Map<String, dynamic> map) {
    return Sales(
      label:map["category_name"],
      earning:map["total"],
    );
  }
}