import 'package:first_flutter/models/sandwich.dart';

class PricingRepository {
  static double calculatePrice({
    required SandwichType type,
    required bool isFootlong,
    required int quantity,
  }) {
    double basePrice;
    switch (type) {
      case SandwichType.veggieDelight:
        basePrice = isFootlong ? 8.50 : 6.50;
        break;
      case SandwichType.chickenTeriyaki:
        basePrice = isFootlong ? 9.50 : 7.50;
        break;
      case SandwichType.tunaMelt:
        basePrice = isFootlong ? 9.00 : 7.00;
        break;
      case SandwichType.meatballMarinara:
        basePrice = isFootlong ? 9.25 : 7.25;
        break;
    }
    return basePrice * quantity;
  }
}
