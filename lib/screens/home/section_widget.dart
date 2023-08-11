import 'package:flutter/material.dart';
import 'package:vending_machine/central_logic/database/vending_machine_data_model.dart';
import 'package:vending_machine/common/c_image.dart';

class SectionWidget extends StatelessWidget {
  final Compartments compartment;
  final List<Drinks> drinks;
  final Function(Drinks drink)? onSelectDrink;

  const SectionWidget({
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
            final drink = drinks[index];

            return GestureDetector(
              onTap: () {
                onSelectDrink?.call(drink);
              },
              child: Row(
                children: [
                  if (drink.imageUrl != null || drink.imageUrl != "") ...[
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: CImage(
                        width: 40,
                        height: 40,
                        radius: 20,
                        imageNetworkUrl: drink.imageUrl,
                      ),
                    )
                  ],
                  Expanded(
                    child: ListTile(
                      title: Text(drink.name!),
                      subtitle: Text('Price: €${drink.priceCents! / 100}'),
                      trailing: Text('${drink.quantity} left'),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        const Divider(height: 1, thickness: 1),
      ],
    );
  }
}
