import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lyqx_test_project/core/widgets/default_sized_box.dart';
import 'package:lyqx_test_project/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lyqx_test_project/features/products/domain/entities/product.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../core/routes/app_router.dart';
import '../../../../core/utils/snackbar_util.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../wishlist/presentation/bloc/wishlist_bloc.dart';
import '../bloc/products_bloc.dart';
import '../bloc/product_details_bloc.dart';

class ProductsPage extends StatefulWidget with SnackbarUtil {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<ProductsBloc>().add(const LoadProductsEvent());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isLoadingMore) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (currentScroll >= maxScroll * 0.8) {
      final state = context.read<ProductsBloc>().state;
      if (state is ProductsLoaded && !state.hasReachedMax) {
        setState(() => _isLoadingMore = true);
        context.read<ProductsBloc>().add(
          const LoadProductsEvent(loadMore: true),
        );
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) setState(() => _isLoadingMore = false);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // Header
            SliverToBoxAdapter(child: _buildHeader(context)),

            // Product List
            BlocBuilder<ProductsBloc, ProductsState>(
              builder: (context, state) {
                if (state is ProductsInitial ||
                    (state is ProductsLoading && !state.isLoadingMore)) {
                  return const SliverFillRemaining(child: LoadingIndicator());
                } else if (state is ProductsError) {
                  return SliverFillRemaining(
                    child: ErrorView(
                      message: state.message,
                      onRetry:
                          () => context.read<ProductsBloc>().add(
                            const LoadProductsEvent(),
                          ),
                    ),
                  );
                } else {
                  final products =
                      state is ProductsLoaded
                          ? state.products
                          : (state as ProductsLoading).previousProducts ?? [];

                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index >= products.length) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        final product = products[index];
                        return _ProductListItem(
                          product: product,
                          onAddToCart: () => _handleAddToCart(context, product),
                          onAddToWishlist:
                              () => _handleAddToWishlist(context, product),
                          onTap: () {
                            debugPrint('productId: ${product.id}');
                            context.pushNamed(
                              AppRouter.productDetails,
                              pathParameters: {
                                'productId': product.id.toString(),
                              },
                            );
                          },
                        );
                      },
                      childCount:
                          products.length +
                          (state is ProductsLoading && state.isLoadingMore
                              ? 1
                              : 0),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    final buttonColor = theme.colorScheme.tertiary;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'John Doe',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    context.read<AuthBloc>().add(LogoutEvent());
                    context.goNamed(AppRouter.login);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Fake Store',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  void _handleAddToCart(BuildContext context, Product product) {
    context.read<CartBloc>().add(AddToCartEvent(product));
    widget.showSuccessSnackbar(context, '${product.title} added to cart');
  }

  void _handleAddToWishlist(BuildContext context, Product product) {
    context.read<WishlistBloc>().add(AddToWishlistEvent(product));
    widget.showSuccessSnackbar(context, '${product.title} added to wishlist');
  }
}

class _ProductListItem extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;
  final VoidCallback onAddToWishlist;
  final VoidCallback onTap;

  const _ProductListItem({
    required this.product,
    required this.onAddToCart,
    required this.onAddToWishlist,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Container(
            width: 80,
            height: 80,
            margin: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(4),
            ),
            child: GestureDetector(
              onTap: () {
                onTap();
              },
              child: CachedNetworkImage(
                imageUrl: product.image,
                fit: BoxFit.cover,
                placeholder:
                    (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                errorWidget:
                    (context, url, error) =>
                        const Icon(Icons.error, size: 24, color: Colors.red),
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  product.category, // Assuming category is artist name
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    // _buildStarRating(),
                    const Icon(Icons.star, color: Colors.black, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      product.rating.rate.toString(),
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                DefaultSizedBox.verticalSmall(),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),

          // Price and Actions
          Row(
            children: [
              BlocBuilder<WishlistBloc, WishlistState>(
                builder: (context, state) {
                  final isInWishlist =
                      state is WishlistLoaded &&
                      state.items.any((item) => item.product.id == product.id);

                  return IconButton(
                    icon: Icon(
                      isInWishlist ? Icons.favorite : Icons.favorite_border,
                      size: 20,
                      color: isInWishlist ? Colors.red : null,
                    ),
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
                        onAddToWishlist();
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
