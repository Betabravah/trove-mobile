import 'package:trove/features/item/data/models/item_model.dart';

abstract class RemoteDatasource {
  Future<List<ItemModel>> getItems();
  Future<ItemModel> getItem(String id);
  Future<ItemModel> createItem(ItemModel item);
  Future<ItemModel> updateItem(ItemModel item);
  Future<void> deleteItem(String id);

  Future<List<ItemModel>> filterItems(String query);
}