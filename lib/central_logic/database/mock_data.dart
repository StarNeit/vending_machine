import 'dart:math';

import 'package:vending_machine/central_logic/database/vending_machine_data_model.dart';

VendingMachineDataModel generateMockData() {
  final random = Random();

  List<Compartments> compartments = List.generate(
    3,
    (index) => Compartments(
      id: index + 1,
      name: 'Compartment ${index + 1}',
    ),
  );

  List<Drinks> drinks = List.generate(
    30,
    (index) => Drinks(
      imageUrl: listImage[random.nextInt(listImage.length)],
      id: index + 1,
      name: 'Drink ${index + 1}',
      priceCents: price[random.nextInt(price.length)],
      quantity: random.nextInt(21),
      compartmentID: random.nextInt(3) + 1,
    ),
  );

  List<Coins> coins = List.generate(
    5,
    (index) => Coins(
      id: index + 1,
      valueCents: [10, 20, 50, 100, 200][index], // Random coin value
      quantity: random.nextInt(101), // Random quantity between 0 and 100
    ),
  );

  return VendingMachineDataModel(
    drinks: drinks,
    coins: coins,
    transaction: [],
    compartments: compartments,
  );
}

List price = [
  110,
  210,
  220,
  250,
  350,
  410,
  420,
  550,
  590,
  610,
  430,
  520,
];

List listImage = [
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTV8Tq0oVyvmv9r8-aVUMNLW1oJgPZZCeeALAR6cO5o&s',
  'https://thumbs.dreamstime.com/b/soda-water-bottle-blank-label-isolated-white-mockup-background-47071823.jpg',
  'https://images.pexels.com/photos/2396220/pexels-photo-2396220.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
  'https://media.istockphoto.com/id/475614605/photo/black-tea-in-a-cup.jpg?s=612x612&w=0&k=20&c=YE2Bq4fRBpzZt_7fCIRDxws7ugxsS-nYlKx3SQioiUY=',
  "https://kingfoodmart.com/_next/image?url=https%3A%2F%2Fstorage.googleapis.com%2Fonelife-public%2F18935049502170.jpg&w=3840&q=75",
];
