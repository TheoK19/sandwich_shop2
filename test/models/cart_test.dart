import 'package:flutter_test/flutter_test.dart';
import 'package:first_flutter/models/cart.dart';
import 'package:first_flutter/models/sandwich.dart';

void main() {
  group('Cart', () {
    late Cart cart;

    final veggieSixInch = Sandwich(
      type: SandwichType.veggieDelight,
      isFootlong: false,
      breadType: BreadType.wheat,
    );

    final chickenFootlong = Sandwich(
      type: SandwichType.chickenTeriyaki,
      isFootlong: true,
      breadType: BreadType.white,
    );

    setUp(() {
      cart = Cart();
    });

    test('starts empty', () {
      expect(cart.itemCount, 0);
      expect(cart.totalPrice, 0.0);
      expect(cart.items, isEmpty);
    });

    test('can add a single item', () {
      cart.addItem(veggieSixInch);
      expect(cart.itemCount, 1);
      expect(cart.items.length, 1);
      expect(cart.items.first.sandwich, veggieSixInch);
    });

    test('adding the same item multiple times increases quantity', () {
      cart.addItem(veggieSixInch);
      cart.addItem(veggieSixInch);
      expect(cart.itemCount, 2);
      expect(cart.items.length, 1);
      expect(cart.items.first.quantity, 2);
    });

    test('can add different items', () {
      cart.addItem(veggieSixInch);
      cart.addItem(chickenFootlong);
      expect(cart.itemCount, 2);
      expect(cart.items.length, 2);
    });

    test('can remove an item', () {
      cart.addItem(veggieSixInch);
      cart.addItem(chickenFootlong);

      cart.removeItem(veggieSixInch);

      expect(cart.itemCount, 1);
      expect(cart.items.length, 1);
      expect(cart.items.first.sandwich, chickenFootlong);
    });

    test('can increase item quantity', () {
      cart.addItem(veggieSixInch);
      final cartItem = cart.items.first;
      cart.increaseQuantity(cartItem);
      expect(cartItem.quantity, 2);
      expect(cart.itemCount, 2);
    });

    test('can decrease item quantity', () {
      cart.addItem(veggieSixInch);
      cart.addItem(veggieSixInch); // quantity is 2
      final cartItem = cart.items.first;

      cart.decreaseQuantity(cartItem);
      expect(cartItem.quantity, 1);
      expect(cart.itemCount, 1);
    });

    test('decreasing quantity to zero removes the item', () {
      cart.addItem(veggieSixInch); // quantity is 1
      final cartItem = cart.items.first;

      cart.decreaseQuantity(cartItem);
      expect(cart.items, isEmpty);
      expect(cart.itemCount, 0);
    });

    test('totalPrice is calculated correctly', () {
      // Six-inch Veggie: 6.50
      cart.addItem(veggieSixInch);
      // Footlong Chicken Teriyaki: 9.50
      cart.addItem(chickenFootlong);
      // Six-inch Veggie again, quantity becomes 2
      cart.addItem(veggieSixInch);

      // (6.50 * 2) + 9.50 = 13.00 + 9.50 = 22.50
      expect(cart.totalPrice, 22.50);
    });

    test('itemCount is calculated correctly', () {
      cart.addItem(veggieSixInch);
      cart.addItem(chickenFootlong);
      cart.addItem(veggieSixInch);

      expect(cart.itemCount, 3);
    });
  });
}
