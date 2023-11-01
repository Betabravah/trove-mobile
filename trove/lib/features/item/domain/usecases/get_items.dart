import 'package:dartz/dartz.dart';
import 'package:trove/core/error/failure.dart';
import 'package:trove/core/usecase/usecase.dart';
import 'package:trove/features/item/domain/entities/item.dart';
import 'package:trove/features/item/domain/repositories/item_repository.dart';


class GetItems implements UseCase<List<Item>, NoParams> {
  final ItemRepository repository;

  GetItems(this.repository);

  @override
  Future<Either<Failure, List<Item>>> call(NoParams params) async {
    return await repository.getAllItems();
  }
}
