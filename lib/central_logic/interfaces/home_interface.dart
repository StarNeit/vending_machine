import 'package:flutter/material.dart';
import 'package:vending_machine/central_logic/database/vending_machine_data_model.dart';

abstract class IHome {
  Future<void> initializeDatabase();
  Future<void> depositCoin(Coins coins);
  Future<VendingMachineDataModel?> getData();
  Future<bool> purchaseDrink(BuildContext context, int priceCents,
      double depositedAmountCents, Drinks drink);
}
