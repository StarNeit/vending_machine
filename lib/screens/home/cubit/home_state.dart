part of 'home_cubit.dart';

class HomeState extends Equatable {
  final VendingMachineDataModel? vendingMachineDataModel;
  final double? userBalance;
  const HomeState({this.vendingMachineDataModel, this.userBalance});

  HomeState copyWith(
      {VendingMachineDataModel? vendingMachineDataModel, double? userBalance}) {
    return HomeState(
        userBalance: userBalance ?? this.userBalance,
        vendingMachineDataModel:
            vendingMachineDataModel ?? this.vendingMachineDataModel);
  }

  @override
  List<Object?> get props => [
        vendingMachineDataModel,
        userBalance,
      ];
}
