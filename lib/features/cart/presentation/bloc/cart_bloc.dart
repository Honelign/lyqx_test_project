import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../products/domain/entities/product.dart';
import '../../domain/entities/cart_item.dart';

part 'cart_event.dart';
part 'cart_state.dart';

@injectable
class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<UpdateCartItemEvent>(_onUpdateCartItem);
    on<ClearCartEvent>(_onClearCart);
    
    // Initialize with empty cart
    emit(const CartLoaded([]));
  }

  void _onAddToCart(
    AddToCartEvent event,
    Emitter<CartState> emit,
  ) {
    final state = this.state;
    if (state is CartLoaded) {
      try {
        final List<CartItem> updatedItems = List.from(state.items);
        final existingItemIndex = updatedItems.indexWhere(
          (item) => item.product.id == event.product.id,
        );

        if (existingItemIndex >= 0) {
          // Update existing item quantity
          final existingItem = updatedItems[existingItemIndex];
          updatedItems[existingItemIndex] = existingItem.copyWith(
            quantity: existingItem.quantity + event.quantity,
          );
        } else {
          // Add new item
          updatedItems.add(
            CartItem(
              product: event.product,
              quantity: event.quantity,
            ),
          );
        }

        emit(CartLoaded(updatedItems));
      } catch (e) {
        emit(CartError(e.toString()));
      }
    }
  }

  void _onRemoveFromCart(
    RemoveFromCartEvent event,
    Emitter<CartState> emit,
  ) {
    final state = this.state;
    if (state is CartLoaded) {
      try {
        final List<CartItem> updatedItems = state.items
            .where((item) => item.product.id != event.productId)
            .toList();
        emit(CartLoaded(updatedItems));
      } catch (e) {
        emit(CartError(e.toString()));
      }
    }
  }

  void _onUpdateCartItem(
    UpdateCartItemEvent event,
    Emitter<CartState> emit,
  ) {
    final state = this.state;
    if (state is CartLoaded) {
      try {
        final List<CartItem> updatedItems = List.from(state.items);
        final itemIndex = updatedItems.indexWhere(
          (item) => item.product.id == event.productId,
        );

        if (itemIndex >= 0) {
          if (event.quantity <= 0) {
            // Remove item if quantity is 0 or less
            updatedItems.removeAt(itemIndex);
          } else {
            // Update quantity
            final item = updatedItems[itemIndex];
            updatedItems[itemIndex] = item.copyWith(quantity: event.quantity);
          }
          emit(CartLoaded(updatedItems));
        }
      } catch (e) {
        emit(CartError(e.toString()));
      }
    }
  }

  void _onClearCart(
    ClearCartEvent event,
    Emitter<CartState> emit,
  ) {
    emit(const CartLoaded([]));
  }
}