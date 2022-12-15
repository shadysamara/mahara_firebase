import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  String? id;
  String? catId;
  String? imageUrl;
  String? name;
  String? description;
  String? price;
  Product({
    this.id,
    this.catId,
    this.imageUrl,
    this.name,
    this.description,
    this.price,
  });



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'catId': catId,
      'imageUrl': imageUrl,
      'name': name,
      'description': description,
      'price': price,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] != null ? map['id'] as String : null,
      catId: map['catId'] != null ? map['catId'] as String : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      price: map['price'] != null ? map['price'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
