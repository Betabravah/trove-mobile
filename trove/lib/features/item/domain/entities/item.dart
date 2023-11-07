import 'package:equatable/equatable.dart';
import 'package:trove/features/item/data/models/item_model.dart';

class Item extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String retailer;
  final String status;

  final double price;
  final double rating;
  final double distance;

  const Item({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.retailer,
    required this.status,
    required this.price,
    required this.rating,
    required this.distance,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        imageUrl,
        retailer,
        status,
        price,
        rating,
        distance,
      ];

  ItemModel toItemModel() {
    return ItemModel(
      id: id,
      name: name,
      description: description,
      imageUrl: imageUrl,
      retailer: retailer,
      status: status,
      price: price,
      rating: rating,
      distance: distance,
    );
  }
}
