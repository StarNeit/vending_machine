import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:vending_machine/central_logic/controllers/statistics_controller.dart';
import 'package:vending_machine/central_logic/database/vending_machine_data_model.dart';

part 'statistics_state.dart';

class StatisticsCubit extends Cubit<StatisticsState> {
  StatisticsCubit() : super(const StatisticsState());

  static StatisticsCubit blocFromContext(BuildContext context) {
    return BlocProvider.of<StatisticsCubit>(context);
  }

  final _controller = GetIt.instance<StatisticController>();

  void getMachineData() async {
    final response = await _controller.getMachineData();
    if (response != null) {
      emit(state.copyWith(vendingMachineDataModel: response));
    }
  }

  String remainCoinsCount() {
    double total = 0;
    if (state.vendingMachineDataModel?.coins != null) {
      state.vendingMachineDataModel?.coins?.forEach((element) {
        final amount = element.quantity! * element.valueCents!;
        total += amount;
      });
    }
    return '€${total / 100}';
  }

  String totalSalesCount() {
    double total = 0;
    if (state.vendingMachineDataModel?.transaction != null) {
      state.vendingMachineDataModel?.transaction?.forEach((element) {
        total += element.totalAmountCents!;
      });
    }
    return '€${total / 100}';
  }

  String formatCurrency(double amount) {
    final currencyFormatter = NumberFormat.currency(
      locale:
          'en_US', // Use the appropriate locale for Euro (e.g., 'de_DE' for German Euro)
      symbol: '€', // Euro symbol
      decimalDigits: 2, // Number of decimal places
    );

    return currencyFormatter.format(amount);
  }
}
