import 'package:flutter_test/flutter_test.dart';
import 'package:vending_machine/central_logic/database/vending_machine_data_model.dart';

void main() {
  test('calculateTotal change money', () {
    const inputCents = 1000;
    const priceCents = 510;

    // Act
    final change = calculateChange(priceCents, inputCents, availableCoins);

    // Assert
    //1000 - 5100 => Change: 200 x 2 + 50 x 1 + 20 x 2
    expect(
      change,
      equals([
        Coins(
          id: 1,
          quantity: 2,
          valueCents: 200,
        ),
        Coins(
          id: 3,
          quantity: 1,
          valueCents: 50,
        ),
        Coins(
          id: 4,
          quantity: 2,
          valueCents: 20,
        ),
      ]),
    );
  });
}

// Arrange
List<Coins> availableCoins = [
  Coins(
    id: 1,
    quantity: 100,
    valueCents: 200,
  ),
  Coins(
    id: 2,
    quantity: 100,
    valueCents: 100,
  ),
  Coins(
    id: 3,
    quantity: 100,
    valueCents: 50,
  ),
  Coins(
    id: 4,
    quantity: 100,
    valueCents: 20,
  ),
  Coins(
    id: 5,
    quantity: 100,
    valueCents: 10,
  ),
];
List<Coins> calculateChange(
    int priceCents, int depositedAmountCents, List<Coins> availableCoins) {
  //Because it always has value so I didn't put nullsafety
  List<Coins> changeCoins = [];
  int remainingChange = depositedAmountCents.toInt() - priceCents;

  // Sort availableCoins in descending order of value
  availableCoins.sort((a, b) => b.valueCents!.compareTo(a.valueCents!));

  for (var coin in availableCoins) {
    int coinCount = remainingChange ~/ coin.valueCents!;
    int usedCoins = coinCount > coin.quantity! ? coin.quantity! : coinCount;

    if (usedCoins > 0) {
      changeCoins.add(
          Coins(quantity: usedCoins, valueCents: coin.valueCents, id: coin.id));
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
