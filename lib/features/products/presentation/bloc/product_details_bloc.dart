import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/product.dart';
import '../../domain/usecases/get_product_by_id_usecase.dart';

part 'product_details_event.dart';
part 'product_details_state.dart';

@injectable
class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  final GetProductByIdUseCase _getProductByIdUseCase;

  ProductDetailsBloc(this._getProductByIdUseCase)
    : super(ProductDetailsInitial()) {
    on<LoadProductDetailsEvent>(_onLoadProductDetails);
  }

  Future<void> _onLoadProductDetails(
    LoadProductDetailsEvent event,
    Emitter<ProductDetailsState> emit,
  ) async {
    emit(ProductDetailsLoading());

    final result = await _getProductByIdUseCase(
      GetProductByIdParams(id: event.productId),
    );

    emit(
      result.fold(
        (failure) => ProductDetailsError(failure.message),
        (product) => ProductDetailsLoaded(product),
      ),
    );
  }
}
