import 'package:json_annotation/json_annotation.dart';

import '../../../products/data/models/product_model.dart';
import '../../../products/domain/entities/product.dart';
import '../../domain/entities/wishlist_item.dart';

part 'wishlist_item_model.g.dart';

@JsonSerializable()
class WishlistItemModel extends WishlistItem {
  @JsonKey(
    toJson: _productToJson,
    fromJson: _productFromJson,
  )
  @override
  final Product product;
  
  const WishlistItemModel({
    required this.product,
    required DateTime addedAt,
  }) : super(
          product: product,
          addedAt: addedAt,
        );

  factory WishlistItemModel.fromJson(Map<String, dynamic> json) => 
      _$WishlistItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$WishlistItemModelToJson(this);

  factory WishlistItemModel.fromEntity(WishlistItem item) {
    return WishlistItemModel(
      product: item.product,
      addedAt: item.addedAt,
    );
  }
  
  // Convert Product to JSON
  static Map<String, dynamic> _productToJson(Product product) {
    if (product is ProductModel) {
      return (product).toJson();
    }
    // Create a ProductModel from the Product entity
    return ProductModel.fromEntity(product).toJson();
  }
  
  // Convert JSON to Product
  static Product _productFromJson(Map<String, dynamic> json) {
    return ProductModel.fromJson(json);
  }
}