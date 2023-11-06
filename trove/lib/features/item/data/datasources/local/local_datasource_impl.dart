import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:trove/core/constants/constants.dart';
import 'package:trove/core/error/exception.dart';
import 'package:trove/features/item/data/datasources/local/local_datasource.dart';
import 'package:trove/features/item/data/models/item_model.dart';

class ItemLocalDataSourceImpl implements ItemLocalDataSource {
  final SharedPreferences sharedPreferences;

  ItemLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<ItemModel>> getLastItems() async {
    final jsonString = sharedPreferences.getString(CACHED_ITEMS);
    if (jsonString != null) {
      final List<dynamic> jsonDecoded = jsonDecode(jsonString);
      final items =
          jsonDecoded.map<ItemModel>((map) => ItemModel.fromJson(map)).toList();

      return items;
    }
    return <ItemModel>[];
  }

  @override
  Future<void> cacheItems(List<ItemModel> itemsToCache) async {
    final jsonEncoded = jsonEncode(itemsToCache);

    await sharedPreferences.setString(CACHED_ITEMS, jsonEncoded);
  }

  @override
  Future<void> cacheItem(ItemModel item) async {
    final items = await getItems();

    final itemIndex = items.indexWhere((element) => element.id == item.id);

    if (itemIndex != -1) {
      items[itemIndex] = item;
    } else {
      items.add(item);
    }

    await cacheItems(items);
  }

  @override
  Future<void> deleteItem(String id) async {
    final items = await getItems();

    final filteredItems = items.where((element) => element.id != id);

    await cacheItems(filteredItems.toList());

  }

  @override
  Future<ItemModel> getItem(String id) async {
    final items = await getItems();

    for (final item in items) {
      if (item.id == id) {
        return item;
      }
    }

    throw const CacheException();
  }

  @override
  Future<List<ItemModel>> getItems() async {
    final jsonEncoded = sharedPreferences.getString(CACHED_ITEMS);

    if (jsonEncoded != null) {
      final List<dynamic> jsonDecoded = jsonDecode(jsonEncoded);
      final items = jsonDecoded
          .map<ItemModel>((map) =>ItemModel.fromJson(map)).
          toList();
      return items;
    }

    return <ItemModel>[];
  }
}
