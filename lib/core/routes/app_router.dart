import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/welcome_page.dart';
import '../../features/products/presentation/pages/product_details_page.dart';
import '../presentation/pages/splash_page.dart';
import '../../main.dart';

@singleton
class AppRouter {
  // Route names
  static const String splash = 'splash';
  static const String welcome = 'welcome';
  static const String login = 'login';
  static const String main = 'main';
  static const String productDetails = 'product-details';

  // Route paths
  static const String splashPath = '/';
  static const String welcomePath = '/welcome';
  static const String loginPath = '/login';
  static const String mainPath = '/main';
  static const String productDetailsPath = '/products/:productId';

  late final GoRouter router;

  AppRouter() {
    router = GoRouter(
      initialLocation: splashPath,
      routes: [
        GoRoute(
          name: splash,
          path: splashPath,
          builder: (context, state) => const SplashPage(),
        ),
        GoRoute(
          name: welcome,
          path: welcomePath,
          builder: (context, state) => const WelcomePage(),
        ),
        GoRoute(
          name: login,
          path: loginPath,
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          name: main,
          path: mainPath,
          builder: (context, state) => const MainScreen(),
        ),
        GoRoute(
          name: productDetails,
          path: productDetailsPath,
          builder: (context, state) {
            final productId = state.pathParameters['productId']!;
            return ProductDetailsPage(productId: int.parse(productId));
          },
        ),
      ],
      errorBuilder:
          (context, state) => Scaffold(
            body: Center(child: Text('Route not found: ${state.uri}')),
          ),
    );
  }
}
