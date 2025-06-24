class Product {
  final int? id; 
  final String title;
  final String description;
  final double price;
  final String? image;
  final String category;
  

  Product({
    this.id,
    required this.title,
    required this.description,
    required this.price,
    this.image,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
      id: int.parse(json['id'].toString()),
      title: json['title'],
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      description: json['description'], 
      category: json['category'], 
      image: json['image_url'],
    );
  }
}