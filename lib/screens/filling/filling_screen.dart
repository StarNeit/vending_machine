import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vending_machine/common/c_container.dart';
import 'package:vending_machine/common/c_text.dart';
import 'package:vending_machine/common/quantity_widget.dart';
import 'package:vending_machine/screens/filling/cubit/filling_cubit.dart';
import 'package:vending_machine/screens/filling/filling_section_widget.dart';
import 'package:vending_machine/utils/drink_input_dialog.dart';

class FillingScreen extends StatefulWidget {
  const FillingScreen({super.key});

  @override
  State<FillingScreen> createState() => _FillingScreenState();
}

class _FillingScreenState extends State<FillingScreen> {
  late FillingCubit _cubit;
  @override
  void initState() {
    _cubit = FillingCubit.blocFromContext(context);
    _cubit.getMachineData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FillingCubit, FillingState>(
      bloc: _cubit,
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: GestureDetector(
            onTap: () async {
              final newDrink = await DrinkInputDialog.show(context);
              if (newDrink != null) {
                _cubit.addNewDrink(newDrink);
              }
            },
            child: Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueAccent,
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const CText(
                            text: 'Machine Filling',
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children:
                                          state.vendingMachineDataModel!.coins!
                                              .map((e) => CoinQuantityWidget(
                                                    coins: e,
                                                  ))
                                              .toList(),
                                    ),
                                    const SizedBox(height: 2),
                                  ],
                                )
                              ]
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                      child: CText(
                        text: 'Stock:',
                        textColor: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                )),
                if (state.vendingMachineDataModel?.drinks != null &&
                    state.vendingMachineDataModel!.drinks!.isNotEmpty) ...[
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final compartment =
                            state.vendingMachineDataModel?.compartments![index];
                        final drinksInSection = state
                            .vendingMachineDataModel?.drinks!
                            .where((drink) =>
                                drink.compartmentID == compartment?.id &&
                                drink.quantity != null &&
                                drink.quantity! >= 0)
                            .toList();

                        return drinksInSection != null &&
                                drinksInSection.isNotEmpty
                            ? FillingSectionWidget(
                                onSelectDrink: (drink) async {},
                                compartment: compartment!,
                                drinks: drinksInSection)
                            : Container();
                      },
                      childCount:
                          state.vendingMachineDataModel?.compartments?.length ??
                              0,
                    ),
                  )
                ]
              ],
            ),
          ),
        );
      },
    );
  }
}
