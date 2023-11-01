import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:trove/core/error/failure.dart';
import 'package:trove/core/usecase/usecase.dart';
import 'package:trove/features/item/domain/entities/item.dart';
import 'package:trove/features/item/domain/repositories/item_repository.dart';

class DeleteItem extends UseCase<Item, DeleteItemParams> {
  final ItemRepository repository;

  DeleteItem(this.repository);

  @override
  Future<Either<Failure, Item>> call(DeleteItemParams params) async {
    return await repository.deleteItem(params.id);
  }
}

class DeleteItemParams extends Equatable {
  final String id;

  const DeleteItemParams(this.id);

  @override
  List<Object?> get props => [id];
}