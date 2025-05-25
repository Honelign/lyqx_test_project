import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/product.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel extends Product {
  @JsonKey(
    toJson: _ratingToJson,
    fromJson: _ratingFromJson,
  )
  @override
  final Rating rating;
  
  const ProductModel({
    required int id,
    required String title,
    required double price,
    required String description,
    required String category,
    required String image,
    required this.rating,
  }) : super(
          id: id,
          title: title,
          price: price,
          description: description,
          category: category,
          image: image,
          rating: rating,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
  
  // Convert Rating to JSON
  static Map<String, dynamic> _ratingToJson(Rating rating) {
    if (rating is RatingModel) {
      return rating.toJson();
    }
    return RatingModel.fromEntity(rating).toJson();
  }
  
  // Convert JSON to Rating
  static Rating _ratingFromJson(Map<String, dynamic> json) {
    return RatingModel.fromJson(json);
  }

  factory ProductModel.fromEntity(Product product) {
    return ProductModel(
      id: product.id,
      title: product.title,
      price: product.price,
      description: product.description,
      category: product.category,
      image: product.image,
      rating: RatingModel.fromEntity(product.rating),
    );
  }
}

@JsonSerializable()
class RatingModel extends Rating {
  const RatingModel({
    required double rate,
    required int count,
  }) : super(
          rate: rate,
          count: count,
        );

  factory RatingModel.fromJson(Map<String, dynamic> json) => _$RatingModelFromJson(json);

  Map<String, dynamic> toJson() => _$RatingModelToJson(this);

  factory RatingModel.fromEntity(Rating rating) {
    return RatingModel(
      rate: rating.rate,
      count: rating.count,
    );
  }
}