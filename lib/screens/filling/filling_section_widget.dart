import 'package:flutter/material.dart';
import 'package:vending_machine/central_logic/database/vending_machine_data_model.dart';
import 'package:vending_machine/common/c_image.dart';
import 'package:vending_machine/common/c_text.dart';
import 'package:vending_machine/screens/filling/drink_quantity_widget.dart';

class FillingSectionWidget extends StatelessWidget {
  final Compartments compartment;
  final List<Drinks> drinks;
  final Function(Drinks drink)? onSelectDrink;

  const FillingSectionWidget({
    super.key,
    required this.compartment,
    required this.drinks,
    this.onSelectDrink,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            compartment.name!,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: drinks.length,
          itemBuilder: (context, index) {
            return DrinkQuantityWidget(
              drinks: drinks[index],
            );
          },
        ),
        const Divider(height: 1, thickness: 1),
      ],
    );
  }
}
