import 'package:flutter/material.dart';
import 'package:vending_machine/central_logic/database/vending_machine_data_model.dart';
import 'package:vending_machine/common/c_image.dart';
import 'package:vending_machine/common/c_text.dart';
import 'package:vending_machine/screens/filling/cubit/filling_cubit.dart';
import 'package:vending_machine/screens/home/cubit/home_cubit.dart';

class DrinkQuantityWidget extends StatefulWidget {
  final Drinks drinks;

  const DrinkQuantityWidget({
    super.key,
    required this.drinks,
  });

  @override
  _QuantityWidgetState createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<DrinkQuantityWidget> {
  int _quantity = 0;
  late Drinks _drinks;

  @override
  void initState() {
    super.initState();
    _drinks = widget.drinks;
    _quantity = _drinks.quantity!;
  }

  void _decreaseQuantity(BuildContext context) {
    setState(() {
      if (_quantity > 0) {
        _quantity--;
        _drinks.quantity = _quantity;
      }
    });
    FillingCubit.blocFromContext(context).updateDrink(_drinks);
  }

  void _increaseQuantity(BuildContext context) async {
    setState(() {
      if (_quantity > 0) {}
      _quantity++;
      _drinks.quantity = _quantity;
    });

    FillingCubit.blocFromContext(context).updateDrink(_drinks);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (_drinks.imageUrl != null || _drinks.imageUrl != "") ...[
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: CImage(
              width: 40,
              height: 40,
              radius: 20,
              imageNetworkUrl: _drinks.imageUrl,
            ),
          )
        ],
        SizedBox(
          width: 150,
          child: ListTile(
            title: Text(_drinks.name!),
            subtitle: Text('Price: €${_drinks.priceCents! / 100}'),
          ),
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
