import 'package:flutter_test/flutter_test.dart';
import 'package:first_flutter/repositories/pricing_repository.dart';

void main() {
  group('PricingRepository', () {
    test('returns 0.0 when quantity is zero (footlong)', () {
      final repo = PricingRepository(isFootlong: true, quantity: 0);
      expect(repo.totalPrice, equals(0.0));
    });

    test('calculates total price for footlong sandwiches', () {
      final repo = PricingRepository(isFootlong: true, quantity: 2);
      // footlong unit price = 5.0
      expect(repo.totalPrice, equals(10.0));
    });

    test('calculates total price for non-footlong (six-inch) sandwiches', () {
      final repo = PricingRepository(isFootlong: false, quantity: 3);
      // six-inch unit price = 3.50
      expect(repo.totalPrice, equals(10.5));
    });
  });
}
