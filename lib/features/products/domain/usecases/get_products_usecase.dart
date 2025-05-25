import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../entities/product.dart';
import '../repositories/products_repository.dart';

@injectable
class GetProductsUseCase {
  final ProductsRepository repository;

  GetProductsUseCase(this.repository);

  Future<Either<Failure, List<Product>>> call(GetProductsParams params) {
    return repository.getProducts(
      limit: params.limit,
      offset: params.offset,
    );
  }
}

class GetProductsParams extends Equatable {
  final int? limit;
  final int? offset;

  const GetProductsParams({
    this.limit,
    this.offset,
  });

  @override
  List<Object?> get props => [limit, offset];
}