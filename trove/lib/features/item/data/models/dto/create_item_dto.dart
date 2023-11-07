import 'dart:io';

class CreateItemDto {
  final String name;
  final String description;
  final double price;
  final String image;
  final String status;

  CreateItemDto({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'image': File(image),
      'status': status,
    };
  }
}
