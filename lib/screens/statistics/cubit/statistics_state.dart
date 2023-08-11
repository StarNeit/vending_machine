part of 'statistics_cubit.dart';

class StatisticsState extends Equatable {
  final VendingMachineDataModel? vendingMachineDataModel;
  const StatisticsState({
    this.vendingMachineDataModel,
  });

  StatisticsState copyWith(
      {VendingMachineDataModel? vendingMachineDataModel, double? userBalance}) {
    return StatisticsState(
        vendingMachineDataModel:
            vendingMachineDataModel ?? this.vendingMachineDataModel);
  }

  @override
  List<Object?> get props => [
        vendingMachineDataModel,
      ];
}
