import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vending_machine/common/c_container.dart';
import 'package:vending_machine/common/c_text.dart';
import 'package:vending_machine/core/route/app_route.dart';
import 'package:vending_machine/screens/statistics/cubit/statistics_cubit.dart';
import 'package:vending_machine/screens/statistics/transaction_list_widget.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  late StatisticsCubit _cubit;

  @override
  void initState() {
    _cubit = StatisticsCubit.blocFromContext(context);
    _cubit.getMachineData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticsCubit, StatisticsState>(
      bloc: _cubit,
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                _cubit.getMachineData();
              },
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                      child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            const CText(
                              text: 'Statistic',
                              textColor: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.arrow_back_sharp,
                                size: 32,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                        child: CContainer(
                          width: double.infinity,
                          radius: 10,
                          borderWidth: 0.2,
                          borderColor: Colors.grey.withOpacity(0.5),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CText(
                                  text: 'Remaining Coins:',
                                  textColor: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                                if (state.vendingMachineDataModel?.coins !=
                                    null) ...[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: state
                                            .vendingMachineDataModel!.coins!
                                            .map((e) => Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: CText(
                                                    text:
                                                        '${e.valueCents} x ${e.quantity}',
                                                  ),
                                                ))
                                            .toList(),
                                      ),
                                      const SizedBox(height: 2),
                                      CText(
                                        text:
                                            'Total: ${_cubit.remainCoinsCount()}',
                                      )
                                    ],
                                  )
                                ]
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                        child: CContainer(
                          width: double.infinity,
                          radius: 10,
                          borderWidth: 0.2,
                          borderColor: Colors.grey.withOpacity(0.5),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const CText(
                                      text: 'Your sales:',
                                      textColor: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 12),
                                      child: CText(
                                        text: _cubit.totalSalesCount(),
                                        textColor: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      ),
                                    )
                                  ],
                                ),
                                const Spacer(),
                                CContainer(
                                  tappedContainer: () {
                                    Navigator.pushNamed(
                                        context, AppRoutes.FILLING);
                                  },
                                  backgroundColor: Colors.orange,
                                  width: 100,
                                  height: 32,
                                  radius: 20,
                                  child: const Center(
                                    child: CText(
                                      text: 'Check Stock',
                                      textColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
                  if (state.vendingMachineDataModel?.transaction != null &&
                      state.vendingMachineDataModel!.transaction!
                          .isNotEmpty) ...[
                    TransactionListWidget(
                      transactions: state.vendingMachineDataModel!.transaction!,
                    )
                  ]
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
