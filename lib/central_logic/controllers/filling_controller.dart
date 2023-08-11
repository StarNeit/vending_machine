import 'package:vending_machine/central_logic/database/vending_machine_data_cached_client.dart';
import 'package:vending_machine/central_logic/database/vending_machine_data_model.dart';
import 'package:vending_machine/central_logic/interfaces/filling_interface.dart';

class FillingController implements IFilling {
  @override
  Future<VendingMachineDataModel?> getMachineData() async {
    return await VendingMachineDataCachedClient.instance.getData();
  }

  @override
  Future<void> updateQuantity(Coins coins) async {
    final data = await VendingMachineDataCachedClient.instance.getData();
    final coinsList = data?.coins;
    if (coinsList != null) {
      for (var i = 0; i < coinsList.length; i++) {
        if (coinsList[i].id == coins.id) {
          coinsList[i].quantity = coins.quantity;
        }
      }
      VendingMachineDataCachedClient.instance.storeData(data: data);
    }

    return;
  }

  @override
  Future<void> updateDrink(Drinks drinks) async {
    final data = await VendingMachineDataCachedClient.instance.getData();
    final drinkList = data?.drinks;
    if (drinkList != null) {
      for (var i = 0; i < drinkList.length; i++) {
        if (drinkList[i].id == drinks.id) {
          drinkList[i].quantity = drinks.quantity;
        }
      }
      VendingMachineDataCachedClient.instance.storeData(data: data);
    }

    return;
  }

  @override
  Future<void> addNewDrink(Drinks drink) async {
    final data = await VendingMachineDataCachedClient.instance.getData();
    final drinkList = data?.drinks;
    if (drinkList != null) {
      drinkList.add(Drinks(
        id: drinkList.length,
        name: drink.name,
        priceCents: drink.priceCents,
        quantity: drink.quantity,
        compartmentID: drink.compartmentID,
        imageUrl: drink.imageUrl,
      ));
      data?.drinks = drinkList;
      VendingMachineDataCachedClient.instance.storeData(data: data);
    }

    return;
  }
}
