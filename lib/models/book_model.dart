class Book {
  late String title;
  late String coverImageUrl;
  late double priceInDollar;
  late List<String> categories;
  late List<String> availableFormat;

  Book(
      {required this.title,
      required this.coverImageUrl,
      required this.priceInDollar,
      required this.categories,
      required this.availableFormat});

  Book.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    coverImageUrl = json['cover_image_url'];
    priceInDollar = json['price_in_dollar'].toDouble();

    if (json['categories'] != null) {
      categories = <String>[];
      json['categories'].forEach((v) {
        categories.add(v);
      });
    }

    if (json['available_format'] != null) {
      availableFormat = <String>[];
      json['available_format'].forEach((v) {
        availableFormat.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['cover_image_url'] = coverImageUrl;
    data['price_in_dollar'] = priceInDollar;
    data['categories'] = categories;
    data['available_format'] = availableFormat;
    return data;
  }
}
