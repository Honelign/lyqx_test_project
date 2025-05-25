/// Constants for API endpoints and related values
class ApiConstants {
  // Base URL
  static const String baseUrl = 'https://fakestoreapi.com';
  
  // Endpoints
  static const String login = '/auth/login';
  static const String products = '/products';
  static const String users = '/users';
  static const String categories = '/products/categories';
  static const String cart = '/carts';
  
  // Pagination
  static const int defaultLimit = 10;
}