import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:trove/core/error/failure.dart';
import 'package:trove/core/usecase/usecase.dart';
import 'package:trove/features/item/domain/entities/item.dart';
import 'package:trove/features/item/domain/repositories/item_repository.dart';

class FilterItems extends UseCase<List<Item>, FilterItemsParams> {
  final ItemRepository repository;

  FilterItems(this.repository);

  @override
  Future<Either<Failure, List<Item>>> call(FilterItemsParams params) async {
    return await repository.filterItems(params.filter);
  }
}

class FilterItemsParams extends Equatable {
  final String filter;

  const FilterItemsParams(this.filter);

  @override
  List<Object?> get props => [filter];
}