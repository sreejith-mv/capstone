class Product {
  final String id;
  final String categoryId;
  final String description;
  final String image;
  final String name;
  final num offerPrice;
  final num price;
  final num rating;
  final bool topSelling;

  Product({
    required this.categoryId,
    required this.id,
    required this.description,
    required this.image,
    required this.name,
    required this.offerPrice,
    required this.price,
    required this.rating,
    required this.topSelling,
  });
}
