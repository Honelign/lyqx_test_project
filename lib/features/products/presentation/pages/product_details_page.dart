import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:lyqx_test_project/core/routes/app_router.dart';
import 'package:lyqx_test_project/core/widgets/default_sized_box.dart';
import 'package:lyqx_test_project/main.dart';

import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../wishlist/presentation/bloc/wishlist_bloc.dart';
import '../bloc/product_details_bloc.dart';

class ProductDetailsPage extends StatefulWidget {
  final int productId;

  const ProductDetailsPage({super.key, required this.productId});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductDetailsBloc>().add(
      LoadProductDetailsEvent(widget.productId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      builder: (context, state) {
        if (state is ProductDetailsLoading) {
          return const Center(child: LoadingIndicator());
        } else if (state is ProductDetailsLoaded) {
          final product = state.product;

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => context.pop(context),
              ),
              actions: [
                BlocBuilder<WishlistBloc, WishlistState>(
                  builder: (context, state) {
                    final isInWishlist =
                        state is WishlistLoaded &&
                        state.items.any(
                          (item) => item.product.id == product.id,
                        );

                    return IconButton(
                      onPressed: () {
                        if (isInWishlist) {
                          context.read<WishlistBloc>().add(
                            RemoveFromWishlistEvent(product.id),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${product.title} removed from wishlist',
                              ),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        } else {
                          context.read<WishlistBloc>().add(
                            AddToWishlistEvent(product),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${product.title} added to wishlist',
                              ),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      icon: Icon(
                        isInWishlist ? Icons.favorite : Icons.favorite_border,

                        size: 22,
                        color: isInWishlist ? Colors.red : Colors.black,
                      ),
                    );
                  },
                ),
              ],
            ),

            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product image
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: double.infinity,
                  color: Colors.grey[200],
                  child: CachedNetworkImage(
                    imageUrl: product.image,
                    fit: BoxFit.contain,
                    placeholder:
                        (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                    errorWidget:
                        (context, url, error) =>
                            const Icon(Icons.error, size: 50),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      // Product title
                      Text(
                        product.title,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Product category
                      Text(
                        product.category.toUpperCase(),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Rating and reviews
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.black87),
                          DefaultSizedBox.horizontalSmall(),
                          Text(
                            '${product.rating.rate} ',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${product.rating.count} Reviews',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Price',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          Text(
                            product.price.toStringAsFixed(2),
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      DefaultSizedBox.horizontalLarge(),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<CartBloc>().add(
                              AddToCartEvent(product),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${product.title} added to cart'),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Add to Cart',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (state is ProductDetailsError) {
          return ErrorView(
            message: state.message,
            onRetry:
                () => context.read<ProductDetailsBloc>().add(
                  LoadProductDetailsEvent(widget.productId),
                ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
