import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:trove/core/error/failure.dart';
import 'package:trove/core/usecase/usecase.dart';
import 'package:trove/features/item/domain/entities/item.dart';
import 'package:trove/features/item/domain/repositories/item_repository.dart';

class CreateItem extends UseCase<Item, CreateItemParams> {
  final ItemRepository repository;

  CreateItem(this.repository);

  @override
  Future<Either<Failure, Item>> call(CreateItemParams params) async {
    return await repository.createItem(params.item);
  }
}

class CreateItemParams extends Equatable {
  final Item item;

  const CreateItemParams(this.item);

  @override
  List<Object?> get props => [item];
}