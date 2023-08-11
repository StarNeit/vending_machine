// ignore_for_file: use_build_context_synchronously

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:vending_machine/central_logic/database/mock_data.dart';
import 'package:vending_machine/central_logic/database/vending_machine_data_cached_client.dart';
import 'package:vending_machine/central_logic/database/vending_machine_data_model.dart';
import 'package:vending_machine/central_logic/interfaces/home_interface.dart';
import 'package:vending_machine/utils/plushbar.dart';

class HomeController implements IHome {
  @override
  Future<VendingMachineDataModel?> initializeDatabase() async {
    if (await VendingMachineDataCachedClient.instance.isExistTable() == false) {
      final mockData = generateMockData();
      await VendingMachineDataCachedClient.instance.storeData(data: mockData);
      return mockData;
    }
    return await VendingMachineDataCachedClient.instance.getData();
  }

  @override
  Future<bool> purchaseDrink(BuildContext context, int priceCents,
      double depositedAmountCents, Drinks drink) async {
    if (depositedAmountCents < priceCents) {
      PpFlushBar.showErrorFlushBar(
          "Your balance is not enough to purchase, please deposit.", context);
      return false;
    }

    if (drink.quantity == 0) {
      PpFlushBar.showErrorFlushBar(
          "The ${drink.name} is out of stock.", context);
      return false;
    }
    VendingMachineDataModel? vendingData =
        await VendingMachineDataCachedClient.instance.getData();

    if (vendingData?.coins != null) {
      final change = calculateChange(
          priceCents, depositedAmountCents, vendingData!.coins!);
      final remain = depositedAmountCents.toInt() - priceCents;
      var message =
          'You purchased successfully, here is your change:\n${depositedAmountCents.toInt()} - $priceCents = $remain\n';
      for (var element in change) {
        message += "\n${element.valueCents} x ${element.quantity}";
      }

      var drinks = vendingData.drinks ?? [];

      for (var i = 0; i < drinks.length; i++) {
        if (drinks[i].id == drink.id) {
          final remain = drinks[i].quantity! - 1;
          drinks[i].quantity = remain;
          break;
        }
      }
      vendingData.drinks = drinks;

      var transaction = vendingData.transaction ?? [];

      transaction.add(
        Transaction(
          timestamp: DateTime.now().toString(),
          drinkId: drink.id,
          totalAmountCents: priceCents,
          depositedAmountCents: depositedAmountCents.toInt(),
        ),
      );
      vendingData.transaction = transaction;

      var coins = vendingData.coins ?? [];

      for (var element in change) {
        for (var i = 0; i < coins.length; i++) {
          if (element.valueCents == coins[i].valueCents) {
            coins[i].quantity = coins[i].quantity! - element.quantity!;
          }
        }
      }

      vendingData.coins = coins;

      VendingMachineDataCachedClient.instance.storeData(data: vendingData);

      showOkAlertDialog(context: context, message: message);
      return true;
    } else {
      PpFlushBar.showErrorFlushBar(
          "There is no coins available in the machine.", context);
      return false;
    }
  }

  List<Coins> calculateChange(
      int priceCents, double depositedAmountCents, List<Coins> availableCoins) {
    //Because it always has value so I didn't put nullsafety
    List<Coins> changeCoins = [];
    int remainingChange = depositedAmountCents.toInt() - priceCents;

    // Sort availableCoins in descending order of value
    availableCoins.sort((a, b) => b.valueCents!.compareTo(a.valueCents!));

    for (var coin in availableCoins) {
      int coinCount = remainingChange ~/ coin.valueCents!;
      int usedCoins = coinCount > coin.quantity! ? coin.quantity! : coinCount;

      if (usedCoins > 0) {
        changeCoins.add(Coins(
            quantity: usedCoins, valueCents: coin.valueCents, id: coin.id));
        remainingChange -= usedCoins * coin.valueCents!;
      }

      if (remainingChange == 0) {
        break;
      }
    }

    if (remainingChange != 0) {
      return [];
    }

    return changeCoins;
  }

  @override
  Future<VendingMachineDataModel?> getData() async {
    return await VendingMachineDataCachedClient.instance.getData();
  }

  @override
  Future<void> depositCoin(Coins coins) async {
    final data = await VendingMachineDataCachedClient.instance.getData();
    final coinsList = data?.coins;
    if (coinsList != null) {
      for (var i = 0; i < coinsList.length; i++) {
        if (coinsList[i].id == coins.id) {
          coinsList[i].quantity = coinsList[i].quantity! + 1;
        }
      }
      data?.coins = coinsList;
      VendingMachineDataCachedClient.instance.storeData(data: data);
    }

    return;
  }
}
