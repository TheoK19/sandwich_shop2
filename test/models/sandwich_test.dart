
import 'package:flutter_test/flutter_test.dart';
import 'package:first_flutter/models/sandwich.dart';

void main() {
  group('Sandwich', () {
    test('Constructor creates a valid sandwich', () {
      const sandwich = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: true,
        breadType: BreadType.wheat,
      );

      expect(sandwich.type, SandwichType.veggieDelight);
      expect(sandwich.isFootlong, isTrue);
      expect(sandwich.breadType, BreadType.wheat);
    });

    group('name getter', () {
      test('returns correct name for Veggie Delight', () {
        const sandwich = Sandwich(
          type: SandwichType.veggieDelight,
          isFootlong: false,
          breadType: BreadType.white,
        );
        expect(sandwich.name, 'Veggie Delight');
      });

      test('returns correct name for Chicken Teriyaki', () {
        const sandwich = Sandwich(
          type: SandwichType.chickenTeriyaki,
          isFootlong: false,
          breadType: BreadType.white,
        );
        expect(sandwich.name, 'Chicken Teriyaki');
      });

      test('returns correct name for Tuna Melt', () {
        const sandwich = Sandwich(
          type: SandwichType.tunaMelt,
          isFootlong: false,
          breadType: BreadType.white,
        );
        expect(sandwich.name, 'Tuna Melt');
      });

      test('returns correct name for Meatball Marinara', () {
        const sandwich = Sandwich(
          type: SandwichType.meatballMarinara,
          isFootlong: false,
          breadType: BreadType.white,
        );
        expect(sandwich.name, 'Meatball Marinara');
      });
    });

    group('image getter', () {
      test('returns correct image path for six-inch veggie delight', () {
        const sandwich = Sandwich(
          type: SandwichType.veggieDelight,
          isFootlong: false,
          breadType: BreadType.white,
        );
        expect(sandwich.image, 'assets/images/veggieDelight_six_inch.png');
      });

      test('returns correct image path for footlong chicken teriyaki', () {
        const sandwich = Sandwich(
          type: SandwichType.chickenTeriyaki,
          isFootlong: true,
          breadType: BreadType.wheat,
        );
        expect(sandwich.image, 'assets/images/chickenTeriyaki_footlong.png');
      });
    });
  });
}
