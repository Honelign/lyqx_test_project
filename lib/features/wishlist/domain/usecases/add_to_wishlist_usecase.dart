import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../../../products/domain/entities/product.dart';
import '../entities/wishlist_item.dart';
import '../repositories/wishlist_repository.dart';

@injectable
class AddToWishlistUseCase {
  final WishlistRepository repository;

  AddToWishlistUseCase(this.repository);

  Future<Either<Failure, List<WishlistItem>>> call(AddToWishlistParams params) {
    return repository.addToWishlist(params.product);
  }
}

class AddToWishlistParams extends Equatable {
  final Product product;

  const AddToWishlistParams({
    required this.product,
  });

  @override
  List<Object> get props => [product];
}