import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:trove/core/error/failure.dart';
import 'package:trove/core/usecase/usecase.dart';
import 'package:trove/features/item/domain/entities/item.dart';
import 'package:trove/features/item/domain/repositories/item_repository.dart';

class UpdateItem extends UseCase<Item, UpdateItemParams> {
  final ItemRepository repository;

  UpdateItem(this.repository);

  @override
  Future<Either<Failure, Item>> call(UpdateItemParams params) async {
    return await repository.updateItem(params.item);
  }
}

class UpdateItemParams extends Equatable {
  final Item item;

  const UpdateItemParams(this.item);

  @override
  List<Object?> get props => [item];
}