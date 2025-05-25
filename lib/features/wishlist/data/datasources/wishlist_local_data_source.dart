import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/wishlist_item_model.dart';

abstract class WishlistLocalDataSource {
  /// Gets all wishlist items from local storage
  Future<List<WishlistItemModel>> getWishlistItems();

  /// Saves wishlist items to local storage
  Future<void> saveWishlistItems(List<WishlistItemModel> items);
}

@LazySingleton(as: WishlistLocalDataSource)
class WishlistLocalDataSourceImpl implements WishlistLocalDataSource {
  final SharedPreferences sharedPreferences;

  static const String wishlistKey = 'WISHLIST_ITEMS';

  WishlistLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<WishlistItemModel>> getWishlistItems() async {
    try {
      final jsonString = sharedPreferences.getString(wishlistKey);
      if (jsonString == null) {
        return [];
      }

      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((item) => WishlistItemModel.fromJson(item)).toList();
    } catch (e) {
      throw CacheException('Failed to get wishlist items from local storage');
    }
  }

  @override
  Future<void> saveWishlistItems(List<WishlistItemModel> items) async {
    try {
      final jsonList = items.map((item) => item.toJson()).toList();
      final jsonString = json.encode(jsonList);
      await sharedPreferences.setString(wishlistKey, jsonString);
    } catch (e) {
      throw CacheException('Failed to save wishlist items to local storage');
    }
  }
}
