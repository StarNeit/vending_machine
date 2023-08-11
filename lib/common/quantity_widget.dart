import 'package:flutter/material.dart';
import 'package:vending_machine/central_logic/database/vending_machine_data_model.dart';
import 'package:vending_machine/common/c_text.dart';
import 'package:vending_machine/screens/filling/cubit/filling_cubit.dart';

class CoinQuantityWidget extends StatefulWidget {
  final Coins coins;

  const CoinQuantityWidget({
    super.key,
    required this.coins,
  });

  @override
  _QuantityWidgetState createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<CoinQuantityWidget> {
  int _quantity = 0;
  late Coins _coins;

  @override
  void initState() {
    super.initState();
    _coins = widget.coins;
    _quantity = _coins.quantity!;
  }

  void _decreaseQuantity(BuildContext context) {
    setState(() {
      if (_quantity > 0) {
        _quantity--;
        _coins.quantity = _quantity;
      }
    });
    FillingCubit.blocFromContext(context).updateQuantity(_coins);
  }

  void _increaseQuantity(BuildContext context) {
    setState(() {
      if (_quantity > 0) {}
      _quantity++;
      _coins.quantity = _quantity;
    });

    FillingCubit.blocFromContext(context).updateQuantity(_coins);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CText(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              text: '${_coins.valueCents} cents',
            ),
            CText(
              fontSize: 12,
              text: 'Quantity:$_quantity',
            ),
          ],
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () => _decreaseQuantity(context),
            ),
            Center(
              child: CText(
                text: '$_quantity',
                textAlign: TextAlign.center,
                fontSize: 16,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _increaseQuantity(context),
            ),
          ],
        ),
      ],
    );
  }
}
