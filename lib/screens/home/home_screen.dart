import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vending_machine/common/c_container.dart';
import 'package:vending_machine/common/c_text.dart';
import 'package:vending_machine/core/route/app_route.dart';
import 'package:vending_machine/screens/home/cubit/home_cubit.dart';
import 'package:vending_machine/screens/home/section_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeCubit _cubit;

  @override
  void initState() {
    _cubit = HomeCubit.blocFromContext(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: _cubit,
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.STATISTIC);
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.lightBlue,
                shape: BoxShape.circle,
              ),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Icon(
                  Icons.analytics,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                  child: CContainer(
                    radius: 10,
                    borderWidth: 0.2,
                    borderColor: Colors.grey.withOpacity(0.5),
                    height: 80,
                    child: ListTile(
                      title:
                          Text(_cubit.formatCurrency(state.userBalance ?? 0)),
                      subtitle: const Text('Your current Balance'),
                      trailing: CContainer(
                        tappedContainer: () {
                          _cubit.showDepositDialog(context);
                        },
                        backgroundColor: Colors.orange,
                        width: 100,
                        height: 32,
                        radius: 20,
                        child: const Center(
                          child: CText(
                            text: 'Deposit',
                            textColor: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CContainer(
                      borderWidth: 0.2,
                      borderColor: Colors.grey.withOpacity(0.5),
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RefreshIndicator(
                          onRefresh: () async {
                            _cubit.fetchData();
                          },
                          child: ListView.builder(
                            itemCount: state.vendingMachineDataModel
                                    ?.compartments?.length ??
                                0,
                            itemBuilder: (context, sectionIndex) {
                              final compartment = state.vendingMachineDataModel
                                  ?.compartments![sectionIndex];
                              final drinksInSection = state
                                  .vendingMachineDataModel?.drinks!
                                  .where((drink) =>
                                      drink.compartmentID == compartment?.id &&
                                      drink.quantity != null &&
                                      drink.quantity! > 0)
                                  .toList();

                              return drinksInSection != null &&
                                      drinksInSection.isNotEmpty
                                  ? SectionWidget(
                                      onSelectDrink: (drink) async {
                                        showOkCancelAlertDialog(
                                                context: context,
                                                title:
                                                    'Do you want to buy ${drink.name} for ${drink.priceCents} cents?')
                                            .then((result) {
                                          if (result == OkCancelResult.ok) {
                                            _cubit.purchaseDrink(context,
                                                drink: drink);
                                          }
                                        });
                                      },
                                      compartment: compartment!,
                                      drinks: drinksInSection)
                                  : Container(); // Empty container for sections without drinks
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
