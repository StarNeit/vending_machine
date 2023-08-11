part of 'filling_cubit.dart';

class FillingState extends Equatable {
  final VendingMachineDataModel? vendingMachineDataModel;
  const FillingState({
    this.vendingMachineDataModel,
  });

  FillingState copyWith(
      {VendingMachineDataModel? vendingMachineDataModel, double? userBalance}) {
    return FillingState(
        vendingMachineDataModel:
            vendingMachineDataModel ?? this.vendingMachineDataModel);
  }

  @override
  List<Object?> get props => [
        vendingMachineDataModel,
      ];
}
