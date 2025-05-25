import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../entities/wishlist_item.dart';
import '../repositories/wishlist_repository.dart';

@injectable
class GetWishlistItemsUseCase {
  final WishlistRepository repository;

  GetWishlistItemsUseCase(this.repository);

  Future<Either<Failure, List<WishlistItem>>> call() {
    return repository.getWishlistItems();
  }
}