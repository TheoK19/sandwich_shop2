import 'package:flutter/material.dart';
import 'package:first_flutter/models/sandwich.dart';
import 'package:first_flutter/views/app_styles.dart';
import 'package:first_flutter/repositories/order_repository.dart';
import 'package:first_flutter/repositories/pricing_repository.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sandwich Shop App',
      home: OrderScreen(maxQuantity: 5),
    );
  }
}

class StylisedButton extends StatelessWidget {
  const StylisedButton({
    super.key,
    this.onPressed,
    this.text,
    this.icon,
    this.backgroundColor = Colors.red,
  });
  final VoidCallback? onPressed;
  final Widget? text;
  final Widget? icon;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: SizedBox(
        width: 20,
        height: 20,
        child: FittedBox(
          fit: BoxFit.contain,
          child: icon ?? const SizedBox.shrink(),
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
      ),
      label: text ?? const SizedBox.shrink(),
    );
  }
}

class OrderScreen extends StatefulWidget {
  final int maxQuantity;

  const OrderScreen({super.key, this.maxQuantity = 10});

  @override
  State<OrderScreen> createState() {
    return _OrderScreenState();
  }
}

class _OrderScreenState extends State<OrderScreen> {
  late final OrderRepository _orderRepository;
  final TextEditingController _notesController = TextEditingController();
  bool _isToasted = false;
  bool _isFootlong = true;
  BreadType _selectedBreadType = BreadType.wheat;
  SandwichType _selectedSandwichType = SandwichType.veggieDelight;

  @override
  void initState() {
    super.initState();
    _orderRepository = OrderRepository(maxQuantity: widget.maxQuantity);
    _notesController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  VoidCallback? _getIncreaseCallback() {
    if (_orderRepository.canIncrement) {
      return () => setState(_orderRepository.increment);
    }
    return null;
  }

  VoidCallback? _getDecreaseCallback() {
    if (_orderRepository.canDecrement) {
      return () => setState(_orderRepository.decrement);
    }
    return null;
  }

  void _onSandwichSizeChanged(bool value) {
    setState(() => _isFootlong = value);
  }

  void _onSandwichTypeSelected(SandwichType? value) {
    if (value != null) {
      setState(() => _selectedSandwichType = value);
    }
  }

  void _onBreadTypeSelected(BreadType? value) {
    if (value != null) {
      setState(() => _selectedBreadType = value);
    }
  }

  List<DropdownMenuEntry<SandwichType>> _buildSandwichTypeDropdownEntries() {
    return SandwichType.values.map((SandwichType sandwich) {
      return DropdownMenuEntry<SandwichType>(
        value: sandwich,
        label: sandwich.name,
      );
    }).toList();
  }

  List<DropdownMenuEntry<BreadType>> _buildBreadTypeDropdownEntries() {
    return BreadType.values.map((BreadType bread) {
      return DropdownMenuEntry<BreadType>(
        value: bread,
        label: bread.name,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    String sandwichSizeName = _isFootlong ? 'footlong' : 'six-inch';
    String noteForDisplay = _notesController.text.isEmpty
        ? 'No notes added.'
        : _notesController.text;
    final String toastText = _isToasted ? 'toasted' : 'untoasted';
    final String imageName = '${_selectedSandwichType.name}_$sandwichSizeName.png';
    final String imagePath = 'assets/images/$imageName';
    double totalPrice = PricingRepository.calculatePrice(
      type: _selectedSandwichType,
      isFootlong: _isFootlong,
      quantity: _orderRepository.quantity,
    );
    String displayText = _orderRepository.quantity > 0
        ? '${_orderRepository.quantity} ${_selectedBreadType.name} $toastText $sandwichSizeName ${_selectedSandwichType.name}(es): ${'🥪' * _orderRepository.quantity} (£${totalPrice.toStringAsFixed(2)})'
        : 'No items in your order yet.';

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/logo.png'),
        ),
        title: const Text(
          'Sandwich Counter',
          style: heading1,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (_orderRepository.quantity > 0)
                Image.asset(
                  imagePath,
                  height: 200,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.fastfood, size: 100);
                  },
                ),
              const SizedBox(height: 20),
              Text(displayText, style: normalText),
              const SizedBox(height: 10),
              if (_orderRepository.quantity > 0)
                Text('Note: $noteForDisplay', style: normalText),
              const SizedBox(height: 20),
              DropdownMenu<SandwichType>(
                textStyle: normalText,
                initialSelection: _selectedSandwichType,
                onSelected: _onSandwichTypeSelected,
                dropdownMenuEntries: _buildSandwichTypeDropdownEntries(),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('six-inch', style: normalText),
                  Switch(
                    value: _isFootlong,
                    onChanged: _onSandwichSizeChanged,
                    key: const Key('sandwich_type_switch'),
                  ),
                  const Text('footlong', style: normalText),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('untoasted', style: normalText),
                  Switch(
                    value: _isToasted,
                    onChanged: (value) {
                      setState(() => _isToasted = value);
                    },
                    key: const Key('toasted_switch'),
                  ),
                  const Text('toasted', style: normalText),
                ],
              ),
              const SizedBox(height: 10),
              DropdownMenu<BreadType>(
                textStyle: normalText,
                initialSelection: _selectedBreadType,
                onSelected: _onBreadTypeSelected,
                dropdownMenuEntries: _buildBreadTypeDropdownEntries(),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: TextField(
                  key: const Key('notes_textfield'),
                  controller: _notesController,
                  decoration: const InputDecoration(
                    labelText: 'Add a note (e.g., no onions)',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StylisedButton(
                    onPressed: _getIncreaseCallback(),
                    icon: const Icon(Icons.add),
                    text: const Text('Add'),
                    backgroundColor: Colors.green,
                  ),
                  const SizedBox(width: 8),
                  StylisedButton(
                    onPressed: _getDecreaseCallback(),
                    icon: const Icon(Icons.remove),
                    text: const Text('Remove'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
