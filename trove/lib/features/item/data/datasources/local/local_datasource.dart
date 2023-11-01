import 'package:trove/features/item/data/models/item_model.dart';


abstract class ItemLocalDataSource {
  Future<List<ItemModel>> getItems();
  Future<ItemModel> getItem(String id);
  Future<ItemModel> deleteItem(String id);

  Future<List<ItemModel>> filterItems(String title);

  Future<List<ItemModel>> getLastItems();
  Future<void> cacheItems(List<ItemModel> items);
  Future<void> cacheItem(ItemModel item);
}