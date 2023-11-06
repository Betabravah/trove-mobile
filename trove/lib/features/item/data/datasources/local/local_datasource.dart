import 'package:trove/features/item/data/models/item_model.dart';


abstract class ItemLocalDataSource {
  Future<List<ItemModel>> getItems();
  Future<ItemModel> getItem(String id);
  Future<void> deleteItem(String id);

  Future<List<ItemModel>> getLastItems();
  Future<void> cacheItems(List<ItemModel> items);
  Future<void> cacheItem(ItemModel item);
}