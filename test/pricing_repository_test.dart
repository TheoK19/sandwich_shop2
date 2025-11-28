import 'package:flutter_test/flutter_test.dart';
import 'package:first_flutter/repositories/pricing_repository.dart';
import 'package:first_flutter/models/sandwich.dart';

void main() {
  group('PricingRepository', () {
    test('calculates total price for veggie delight sandwiches', () {
      // footlong
      double price = PricingRepository.calculatePrice(
        type: SandwichType.veggieDelight,
        isFootlong: true,
        quantity: 2,
      );
      expect(price, equals(17.0));

      // six-inch
      price = PricingRepository.calculatePrice(
        type: SandwichType.veggieDelight,
        isFootlong: false,
        quantity: 3,
      );
      expect(price, equals(19.5));
    });

    test('calculates total price for chicken teriyaki sandwiches', () {
      // footlong
      double price = PricingRepository.calculatePrice(
        type: SandwichType.chickenTeriyaki,
        isFootlong: true,
        quantity: 1,
      );
      expect(price, equals(9.50));

      // six-inch
      price = PricingRepository.calculatePrice(
        type: SandwichType.chickenTeriyaki,
        isFootlong: false,
        quantity: 4,
      );
      expect(price, equals(30.0));
    });

    test('returns 0.0 when quantity is zero', () {
      final price = PricingRepository.calculatePrice(
        type: SandwichType.tunaMelt,
        isFootlong: true,
        quantity: 0,
      );
      expect(price, equals(0.0));
    });
  });
}
