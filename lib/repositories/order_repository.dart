class OrderRepository {
  int _quantity = 1;
  final int maxQuantity;

  OrderRepository({this.maxQuantity = 10});

  int get quantity => _quantity;

  bool get canIncrement => _quantity < maxQuantity;

  bool get canDecrement => _quantity > 1;

  void increment() {
    if (canIncrement) {
      _quantity++;
    }
  }

  void decrement() {
    if (canDecrement) {
      _quantity--;
    }
  }
}
