import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:vending_machine/central_logic/controllers/filling_controller.dart';
import 'package:vending_machine/central_logic/database/vending_machine_data_model.dart';

part 'filling_state.dart';

class FillingCubit extends Cubit<FillingState> {
  FillingCubit() : super(const FillingState());

  final _controller = GetIt.instance<FillingController>();

  static FillingCubit blocFromContext(BuildContext context) {
    return BlocProvider.of<FillingCubit>(context);
  }

  void getMachineData() async {
    final response = await _controller.getMachineData();
    if (response != null) {
      emit(state.copyWith(vendingMachineDataModel: response));
    }
  }

  void addNewDrink(Drinks drink) async {
    await _controller.addNewDrink(drink);
    getMachineData();
  }

  void updateQuantity(Coins coin) {
    _controller.updateQuantity(coin);
  }

  void updateDrink(Drinks drink) {
    _controller.updateDrink(drink);
  }
}
