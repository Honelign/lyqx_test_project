import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../products/domain/entities/product.dart';
import '../../domain/entities/wishlist_item.dart';
import '../../domain/usecases/add_to_wishlist_usecase.dart';
import '../../domain/usecases/get_wishlist_items_usecase.dart';
import '../../domain/usecases/remove_from_wishlist_usecase.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

@injectable
class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final GetWishlistItemsUseCase _getWishlistItemsUseCase;
  final AddToWishlistUseCase _addToWishlistUseCase;
  final RemoveFromWishlistUseCase _removeFromWishlistUseCase;

  WishlistBloc(
    this._getWishlistItemsUseCase,
    this._addToWishlistUseCase,
    this._removeFromWishlistUseCase,
  ) : super(WishlistInitial()) {
    on<LoadWishlistEvent>(_onLoadWishlist);
    on<AddToWishlistEvent>(_onAddToWishlist);
    on<RemoveFromWishlistEvent>(_onRemoveFromWishlist);
    on<ClearWishlistEvent>(_onClearWishlist);
    
    // Load wishlist on initialization
    add(LoadWishlistEvent());
  }

  Future<void> _onLoadWishlist(
    LoadWishlistEvent event,
    Emitter<WishlistState> emit,
  ) async {
    emit(WishlistLoading());

    final result = await _getWishlistItemsUseCase();

    emit(result.fold(
      (failure) => WishlistError(failure.message),
      (items) => WishlistLoaded(items),
    ));
  }

  Future<void> _onAddToWishlist(
    AddToWishlistEvent event,
    Emitter<WishlistState> emit,
  ) async {
    emit(WishlistLoading());

    final result = await _addToWishlistUseCase(
      AddToWishlistParams(product: event.product),
    );

    emit(result.fold(
      (failure) => WishlistError(failure.message),
      (items) => WishlistLoaded(items),
    ));
  }

  Future<void> _onRemoveFromWishlist(
    RemoveFromWishlistEvent event,
    Emitter<WishlistState> emit,
  ) async {
    emit(WishlistLoading());

    final result = await _removeFromWishlistUseCase(
      RemoveFromWishlistParams(productId: event.productId),
    );

    emit(result.fold(
      (failure) => WishlistError(failure.message),
      (items) => WishlistLoaded(items),
    ));
  }

  Future<void> _onClearWishlist(
    ClearWishlistEvent event,
    Emitter<WishlistState> emit,
  ) async {
    emit(WishlistLoading());
    emit(const WishlistLoaded([]));
  }
}