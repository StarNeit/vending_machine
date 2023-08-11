import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:vending_machine/central_logic/controllers/home_controller.dart';
import 'package:vending_machine/central_logic/database/vending_machine_data_model.dart';
import 'package:vending_machine/common/c_container.dart';
import 'package:vending_machine/common/c_text.dart';
import 'package:vending_machine/screens/home/numberic_text_field.dart';
import 'package:vending_machine/utils/my_logger.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());
  final _controller = GetIt.instance<HomeController>();

  double _depositAmount = 100;

  static HomeCubit blocFromContext(BuildContext context) {
    return BlocProvider.of<HomeCubit>(context);
  }

  void initializeDatabase() async {
    try {
      final response = await _controller.initializeDatabase();

      if (response != null) {
        emit(state.copyWith(
          vendingMachineDataModel: response,
        ));
      }
    } catch (e) {
      MyLogger().d(e);
    }
  }

  void updateUserBalance() {
    final userBalance = state.userBalance ?? 0;
    final total = userBalance + _depositAmount;
    emit(state.copyWith(userBalance: total));
    _depositAmount = 0;
  }

  void depositCoin(Coins coin) {
    _depositAmount = coin.valueCents!.toDouble();
    _controller.depositCoin(coin);
    updateUserBalance();
  }

  void showDepositDialog(BuildContext context) {
    showGeneralDialog(
        barrierLabel: "Barrier",
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: const Duration(milliseconds: 300),
        context: context,
        pageBuilder: (_, __, ___) {
          return Align(
            alignment: Alignment.center,
            child: Container(
              width: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Material(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Flexible(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(12, 16, 16, 12),
                        child: CText(
                          lineSpacing: 1.5,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
                          text:
                              'Enter amount of money you want to deposit in Europe Cents:',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: CoinDepositTextField(
                        availableCoins: state.vendingMachineDataModel!.coins!,
                        onChanged: (coin) {
                          Navigator.pop(context);
                          depositCoin(coin);
                        },
                      ),
                    ),
                    const Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 56,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: CContainer(
                              height: double.infinity,
                              width: double.infinity,
                              tappedContainer: (() {
                                updateUserBalance();
                                Navigator.pop(context);
                              }),
                              child: const Center(
                                child: CText(
                                  fontSize: 15,
                                  textAlign: TextAlign.center,
                                  text: 'OK',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          const VerticalDivider(
                            color: Colors.grey,
                            thickness: 1,
                          ),
                          Expanded(
                            flex: 1,
                            child: CContainer(
                              height: double.infinity,
                              width: double.infinity,
                              tappedContainer: () {
                                Navigator.pop(context);
                              },
                              child: const Center(
                                child: CText(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  textAlign: TextAlign.center,
                                  text: 'Cancel',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  String formatCurrency(double amount) {
    final currencyFormatter = NumberFormat.currency(
      locale: 'en_US',
      symbol: '€',
      decimalDigits: 2,
    );

    return currencyFormatter.format(amount / 100);
  }

  void fetchData() async {
    try {
      final response = await _controller.getData();

      if (response != null) {
        emit(state.copyWith(
          vendingMachineDataModel: response,
        ));
      }
    } catch (e) {
      MyLogger().d(e);
    }
  }

  void purchaseDrink(BuildContext context, {required Drinks drink}) async {
    if (state.userBalance != null) {
      _controller
          .purchaseDrink(context, drink.priceCents!, state.userBalance!, drink)
          .then((isSuccess) {
        if (isSuccess) {
          emit(state.copyWith(userBalance: 0));
        }
        fetchData();
      });
    }
  }
}
