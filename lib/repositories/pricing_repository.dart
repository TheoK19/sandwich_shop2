class PricingRepository {
  final bool isFootlong;
  final int quantity;

  PricingRepository({required this.isFootlong, required this.quantity});

  double get _itemPrice {
    return isFootlong ? 5.00 : 3.50;
  }

  double get totalPrice => _itemPrice * quantity;
}
