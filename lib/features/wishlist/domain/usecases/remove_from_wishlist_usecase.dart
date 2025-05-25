import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../entities/wishlist_item.dart';
import '../repositories/wishlist_repository.dart';

@injectable
class RemoveFromWishlistUseCase {
  final WishlistRepository repository;

  RemoveFromWishlistUseCase(this.repository);

  Future<Either<Failure, List<WishlistItem>>> call(RemoveFromWishlistParams params) {
    return repository.removeFromWishlist(params.productId);
  }
}

class RemoveFromWishlistParams extends Equatable {
  final int productId;

  const RemoveFromWishlistParams({
    required this.productId,
  });

  @override
  List<Object> get props => [productId];
}