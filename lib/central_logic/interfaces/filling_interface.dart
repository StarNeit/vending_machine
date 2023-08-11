import 'package:vending_machine/central_logic/database/vending_machine_data_model.dart';

abstract class IFilling {
  Future<VendingMachineDataModel?> getMachineData();
  Future<void> updateQuantity(Coins coins);
  Future<void> updateDrink(Drinks coins);
  Future<void> addNewDrink(Drinks drink);
}
