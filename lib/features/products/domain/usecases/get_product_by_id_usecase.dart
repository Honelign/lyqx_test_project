import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../entities/product.dart';
import '../repositories/products_repository.dart';

@injectable
class GetProductByIdUseCase {
  final ProductsRepository repository;

  GetProductByIdUseCase(this.repository);

  Future<Either<Failure, Product>> call(GetProductByIdParams params) {
    return repository.getProductById(params.id);
  }
}

class GetProductByIdParams extends Equatable {
  final int id;

  const GetProductByIdParams({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}