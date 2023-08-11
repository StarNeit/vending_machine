import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vending_machine/central_logic/database/mock_data.dart';
import 'package:vending_machine/central_logic/database/vending_machine_data_model.dart';

class DrinkInputDialog {
  static Future<Drinks?> show(BuildContext context) async {
    Drinks? newDrink;

    return showDialog<Drinks>(
      context: context,
      builder: (BuildContext context) {
        String? name;
        int? priceCents;
        int? quantity;
        int? compartmentID;

        return AlertDialog(
          title: Text('Add a New Drink'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                onChanged: (value) => name = value,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                onChanged: (value) => priceCents = int.tryParse(value),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Price (cents)'),
              ),
              TextField(
                onChanged: (value) => quantity = int.tryParse(value),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Quantity'),
              ),
              TextField(
                onChanged: (value) => compartmentID = int.tryParse(value),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Compartment Floor'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                newDrink = Drinks(
                  imageUrl: listImage[Random().nextInt(listImage.length)],
                  compartmentID: compartmentID,
                  name: name,
                  priceCents: priceCents,
                  quantity: quantity,
                );
                Navigator.of(context).pop(newDrink);
              },
            ),
          ],
        );
      },
    );
  }
}
