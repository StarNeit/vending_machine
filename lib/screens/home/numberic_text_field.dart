import 'package:flutter/material.dart';
import 'package:vending_machine/central_logic/database/vending_machine_data_model.dart';
import 'package:vending_machine/common/c_text.dart';

class CoinDepositTextField extends StatefulWidget {
  final Function(Coins) onChanged;
  final List<Coins> availableCoins;

  const CoinDepositTextField({
    required this.onChanged,
    required this.availableCoins,
  });

  @override
  _NumericTextFieldState createState() => _NumericTextFieldState();
}

class _NumericTextFieldState extends State<CoinDepositTextField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Wrap(
        children: widget.availableCoins.map((e) => coinWidget(e)).toList(),
      ),
    );
  }

  Widget coinWidget(Coins coin) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          widget.onChanged.call(coin);
        },
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.orange,
          ),
          width: 60,
          height: 60,
          child: Center(
              child: CText(
            textAlign: TextAlign.center,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            textColor: Colors.white,
            text: "${coin.valueCents} ",
          )),
        ),
      ),
    );
  }
}
