import 'package:dartz/dartz.dart';
import 'package:trove/core/error/failure.dart';
import 'package:trove/features/item/domain/entities/item.dart';

abstract class ItemRepository {
  Future<Either<Failure, List<Item>>> getItems();
  Future<Either<Failure, Item>> getItem(String id);
  Future<Either<Failure, Item>> createItem(Item item);
  Future<Either<Failure, Item>> updateItem(Item item);
  Future<Either<Failure, Item>> deleteItem(String id);

  Future<Either<Failure, List<Item>>> filterItems(String title);
}
