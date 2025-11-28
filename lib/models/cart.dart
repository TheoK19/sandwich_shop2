import 'package:first_flutter/models/sandwich.dart';
import 'package:first_flutter/repositories/pricing_repository.dart';

class CartItem {
  final Sandwich sandwich;
  int quantity;

  CartItem({required this.sandwich, this.quantity = 1});

  double get itemPrice {
    return PricingRepository.calculatePrice(
      type: sandwich.type,
      isFootlong: sandwich.isFootlong,
      quantity: quantity,
    );
  }
}

class Cart {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice {
    return _items.fold(0.0, (sum, item) => sum + item.itemPrice);
  }

  void addItem(Sandwich sandwich) {
    final existingItemIndex = _items.indexWhere(
      (item) => item.sandwich == sandwich,
    );

    if (existingItemIndex != -1) {
      _items[existingItemIndex].quantity++;
    } else {
      _items.add(CartItem(sandwich: sandwich));
    }
  }

  void removeItem(Sandwich sandwich) {
    _items.removeWhere(
      (item) => item.sandwich == sandwich,
    );
  }

  void increaseQuantity(CartItem cartItem) {
    cartItem.quantity++;
  }

  void decreaseQuantity(CartItem cartItem) {
    if (cartItem.quantity > 1) {
      cartItem.quantity--;
    } else {
      removeItem(cartItem.sandwich);
    }
  }
}
