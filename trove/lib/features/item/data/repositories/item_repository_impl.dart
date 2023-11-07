import 'package:dartz/dartz.dart';
import 'package:trove/core/error/failure.dart';
import 'package:trove/core/network/network_info.dart';
import 'package:trove/features/item/data/datasources/local/local_datasource.dart';
import 'package:trove/features/item/data/datasources/remote/remote_datasource.dart';
import 'package:trove/features/item/domain/entities/item.dart';
import 'package:trove/features/item/domain/repositories/item_repository.dart';

class ItemRepositoryImpl implements ItemRepository {
  final ItemLocalDataSource localDataSource;
  final ItemRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ItemRepositoryImpl(
      {required this.localDataSource,
      required this.remoteDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, Item>> createItem(Item item) async {
    if (await networkInfo.isConnected) {
      try {
        final createdItem =
            await remoteDataSource.createItem(item.toItemModel());
        localDataSource.cacheItem(createdItem);
        return Right(createdItem);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Item>> deleteItem(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final deletedItem = await remoteDataSource.deleteItem(id);
        localDataSource.deleteItem(id);
        return Right(deletedItem);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Item>>> filterItems(String title) async {
    if (await networkInfo.isConnected) {
      try {
        final filteredItems = await remoteDataSource.filterItems(title);
        return Right(filteredItems);
      } catch (e) {
        final cachedItems = await localDataSource.getItems();
        return Right(cachedItems);
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Item>> getItem(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final item = await remoteDataSource.getItem(id);
        await localDataSource.cacheItem(item);
        return Right(item);
      } catch (e) {
        try {
          final cachedItem = await localDataSource.getItem(id);
          return Right(cachedItem);
        } catch (e) {
          return Left(CacheFailure());
        }
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Item>>> getItems() async {
    if (await networkInfo.isConnected) {
      try {
        final items = await remoteDataSource.getItems();
        localDataSource.cacheItems(items);
        return Right(items);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      try {
        final cachedItems = await localDataSource.getItems();
        return Right(cachedItems);
      } catch (e) {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Item>> updateItem(Item item) async {
    if (await networkInfo.isConnected) {
      try {
        final updatedItem =
            await remoteDataSource.updateItem(item.toItemModel());
        localDataSource.cacheItem(updatedItem);
        return Right(updatedItem);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
