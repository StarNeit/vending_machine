import 'package:equatable/equatable.dart';

class VendingMachineDataModel {
  List<Drinks>? drinks;
  List<Coins>? coins;
  List<Transaction>? transaction;
  final List<Compartments>? compartments;

  VendingMachineDataModel({
    this.drinks,
    this.coins,
    this.transaction,
    this.compartments,
  });

  VendingMachineDataModel.fromJson(Map<String, dynamic> json)
      : drinks = (json['drinks'] as List?)
            ?.map((dynamic e) => Drinks.fromJson(e as Map<String, dynamic>))
            .toList(),
        coins = (json['coins'] as List?)
            ?.map((dynamic e) => Coins.fromJson(e as Map<String, dynamic>))
            .toList(),
        compartments = (json['compartments'] as List?)
            ?.map(
                (dynamic e) => Compartments.fromJson(e as Map<String, dynamic>))
            .toList(),
        transaction = (json['transaction'] as List?)
            ?.map(
                (dynamic e) => Transaction.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'drinks': drinks?.map((e) => e.toJson()).toList(),
        'coins': coins?.map((e) => e.toJson()).toList(),
        'transaction': transaction?.map((e) => e.toJson()).toList(),
        'compartments': compartments?.map((e) => e.toJson()).toList(),
      };
}

class Drinks {
  final int? id;
  final String? name;
  final String? imageUrl;
  final int? priceCents;
  int? quantity;
  final int? compartmentID;

  Drinks({
    this.id,
    this.name,
    this.priceCents,
    this.quantity,
    this.compartmentID,
    this.imageUrl,
  });

  Drinks.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        imageUrl = json['image_url'] as String?,
        priceCents = json['price_cents'] as int?,
        quantity = json['quantity'] as int?,
        compartmentID = json['compartmentID'] as int?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price_cents': priceCents,
        'quantity': quantity,
        'compartmentID': compartmentID,
        'image_url': imageUrl,
      };
}

class Coins extends Equatable {
  final int? id;
  int? quantity;
  final int? valueCents;

  Coins({
    this.id,
    this.quantity,
    this.valueCents,
  });

  Coins.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        quantity = json['quantity'] as int?,
        valueCents = json['value_cents'] as int?;

  Map<String, dynamic> toJson() =>
      {'id': id, 'quantity': quantity, 'value_cents': valueCents};

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        quantity,
      ];
}

class Transaction {
  final String? timestamp;
  final int? drinkId;
  final int? totalAmountCents;
  final int? depositedAmountCents;

  Transaction({
    this.timestamp,
    this.drinkId,
    this.totalAmountCents,
    this.depositedAmountCents,
  });

  Transaction.fromJson(Map<String, dynamic> json)
      : timestamp = json['timestamp'] as String?,
        drinkId = json['drink_id'] as int?,
        totalAmountCents = json['total_amount_cents'] as int?,
        depositedAmountCents = json['deposited_amount_cents'] as int?;

  Map<String, dynamic> toJson() => {
        'timestamp': timestamp,
        'drink_id': drinkId,
        'total_amount_cents': totalAmountCents,
        'deposited_amount_cents': depositedAmountCents
      };
}

class Compartments {
  final int? id;
  final String? name;

  Compartments({
    this.id,
    this.name,
  });

  Compartments.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?;

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
