import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:trove/core/error/failure.dart';
import 'package:trove/core/usecase/usecase.dart';
import 'package:trove/features/item/domain/entities/item.dart';
import 'package:trove/features/item/domain/repositories/item_repository.dart';

class GetItem extends UseCase<Item, GetItemParams> {
  final ItemRepository repository;

  GetItem(this.repository);

  @override
  Future<Either<Failure, Item>> call(GetItemParams params) async {
    return await repository.getItem(params.id);
  }
}

class GetItemParams extends Equatable {
  final String id;

  const GetItemParams(this.id);

  @override
  List<Object?> get props => [id];
}