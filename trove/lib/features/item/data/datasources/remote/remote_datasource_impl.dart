import 'dart:convert';

import 'package:http/http.dart';
import 'package:trove/core/error/exception.dart';
import 'package:trove/core/network/custom_client.dart';
import 'package:trove/features/item/data/datasources/remote/remote_datasource.dart';
import 'package:trove/features/item/data/models/dto/create_item_dto.dart';
import 'package:trove/features/item/data/models/item_model.dart';

class RemoteDataSourceImpl implements ItemRemoteDataSource {
  final CustomClient client;

  RemoteDataSourceImpl({required this.client});

  @override
  Future<ItemModel> createItem(ItemModel item) async {
    final dto = CreateItemDto(
        name: item.name,
        description: item.description,
        price: item.price,
        image: item.imageUrl,
        status: item.status);

    StreamedResponse response;

    try {
      response = await client.multipartRequest(
        'item/',
        method: 'POST',
        body: dto.toJson(),
      );
    } catch (e) {
      throw const ServerException(message: 'Connection Failed');
    }

    if (response.statusCode == 200) {
      try {
        final data = await response.stream.bytesToString();

        final decoded = jsonDecode(data)['data'];

        final itemModel = ItemModel.fromJson(decoded);
        return itemModel;
      } on FormatException {
        throw const ServerException(message: 'Invalid Response');
      }
    } else {
      throw const ServerException(message: 'Operation Failed');
    }
  }

  @override
  Future<ItemModel> deleteItem(String id) async {
    try {
      final response = await client.delete('item/$id');

      if (response.statusCode == 200) {
        try {
          final decoded = jsonDecode(response.body)['data'];
          final itemModel = ItemModel.fromJson(decoded);

          return itemModel;
        } on FormatException {
          throw const ServerException(message: 'Invalid Response');
        }
      } else {
        throw const ServerException(message: 'Operation Failed');
      }
    } catch (e) {
      throw const ServerException(message: 'Connection Failed');
    }
  }

  @override
  Future<List<ItemModel>> filterItems(String query) async {
    try {
      final response =
          await client.get('item/', queryParams: {'searchParams': query});

      if (response.statusCode == 200) {
        try {
          final decoded = jsonDecode(response.body)['data'];

          final itemModel =
              decoded.map<ItemModel>((map) => ItemModel.fromJson(map)).toList();

          return itemModel;
        } on FormatException {
          throw const ServerException(message: 'Invalid Response');
        }
      } else {
        throw const ServerException(message: 'Operation Failed');
      }
    } catch (e) {
      throw const ServerException(message: 'Connection Failed');
    }
  }

  @override
  Future<ItemModel> getItem(String id) async {
    try {
      final response = await client.get('item/$id');

      if (response.statusCode == 200) {
        try {
          final decoded = jsonDecode(response.body)['data'];

          final itemModel = ItemModel.fromJson(decoded);

          return itemModel;
        } on FormatException {
          throw const ServerException(message: 'Invalid Response');
        }
      } else {
        throw const ServerException(message: 'Operation Failed');
      }
    } catch (e) {
      throw const ServerException(message: 'Connection Failed');
    }
  }

  @override
  Future<List<ItemModel>> getItems() async {
    try {
      final response = await client.get('item/');

      if (response.statusCode == 200) {
        try {
          final decoded = jsonDecode(response.body)['data'];
          final items =
              decoded.map<ItemModel>((map) => ItemModel.fromJson(map)).toList();

          return items;
        } on FormatException {
          throw const ServerException(message: 'Invalid Response');
        }
      } else {
        throw const ServerException(message: 'Operation Failed');
      }
    } catch (e) {
      throw const ServerException(message: 'Connection Failed');
    }
  }

  @override
  Future<ItemModel> updateItem(ItemModel item) async {
    final dto = CreateItemDto(
        name: item.name,
        description: item.description,
        price: item.price,
        image: item.imageUrl,
        status: item.status);

    StreamedResponse response;

    try {
      response = await client.multipartRequest(
          method: 'PUT', 'item/${item.id}', body: dto.toJson());

      if (response.statusCode == 200) {
        try {
          final data = await response.stream.bytesToString();

          final decoded = jsonDecode(data)['data'];

          final itemModel = ItemModel.fromJson(decoded);

          return itemModel;
        } on FormatException {
          throw const ServerException(message: 'Invalid Response');
        }
      } else {
        throw const ServerException(message: 'Operation Failed');
      }
    } catch (e) {
      throw const ServerException(message: 'Connection Failed');
    }
  }
}
