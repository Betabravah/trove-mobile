import 'package:trove/features/item/domain/entities/item.dart';

class ItemModel extends Item {
  const ItemModel(
      {required super.id,
      required super.name,
      required super.description,
      required super.imageUrl,
      required super.retailer,
      required super.status,
      required super.price,
      required super.rating,
      required super.distance});

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      retailer: json['retailer'],
      status: json['status'],
      price: json['price'],
      rating: json['rating'],
      distance: json['distance'],
    );
  }

  Map toJson() {
    return {
      'id': super.id,
      'name': super.name,
      'description': super.description,
      'imageUrl': super.imageUrl,
      'retailer': super.retailer,
      'status': super.status,
      'price': super.price,
      'rating': super.rating,
      'distance': super.distance,
    };
  }
}
