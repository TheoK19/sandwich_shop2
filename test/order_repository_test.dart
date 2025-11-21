import 'package:flutter_test/flutter_test.dart';
import 'package:first_flutter/order_repository.dart';

void main() {
  group('OrderRepository', () {
    test('initial quantity should be 1', () {
      final repository = OrderRepository();
      expect(repository.quantity, 1);
    });

    test('increment should increase quantity by 1', () {
      final repository = OrderRepository();
      repository.increment();
      expect(repository.quantity, 2);
    });

    test('decrement should decrease quantity by 1', () {
      final repository = OrderRepository();
      repository.increment(); // quantity is now 2
      repository.decrement(); // quantity is now 1
      expect(repository.quantity, 1);
    });

    test('quantity should not go below 1', () {
      final repository = OrderRepository();
      repository.decrement(); // should not do anything as quantity is already 1
      expect(repository.quantity, 1);
      expect(repository.canDecrement, isFalse);
    });

    test('quantity should not exceed maxQuantity', () {
      final repository = OrderRepository(maxQuantity: 2);
      repository.increment(); // quantity is now 2
      repository.increment(); // should not do anything
      expect(repository.quantity, 2);
      expect(repository.canIncrement, isFalse);
    });

    test('canIncrement should be true when quantity < maxQuantity', () {
      final repository = OrderRepository(maxQuantity: 5);
      expect(repository.canIncrement, isTrue);
    });

    test('canIncrement should be false when quantity == maxQuantity', () {
      final repository = OrderRepository(maxQuantity: 1); // initial quantity is 1
      expect(repository.canIncrement, isFalse);
    });

    test('canDecrement should be false when quantity is 1', () {
      final repository = OrderRepository();
      expect(repository.canDecrement, isFalse);
    });

    test('canDecrement should be true when quantity > 1', () {
      final repository = OrderRepository();
      repository.increment();
      expect(repository.canDecrement, isTrue);
    });
  });
}
