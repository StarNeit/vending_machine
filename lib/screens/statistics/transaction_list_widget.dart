import 'package:flutter/material.dart';
import 'package:vending_machine/central_logic/database/vending_machine_data_model.dart';

class TransactionListWidget extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionListWidget({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final transaction = transactions[index];
          return Container(
            color: Colors.white,
            child: ListTile(
              title: Text('Drink ID: ${transaction.drinkId ?? 'N/A'}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Total Amount: ${transaction.totalAmountCents ?? 'N/A'} cents'),
                  Text(
                      'Deposited Amount: ${transaction.depositedAmountCents ?? 'N/A'} cents'),
                  Text('Timestamp: ${transaction.timestamp ?? 'N/A'}'),
                ],
              ),
            ),
          );
        },
        childCount: transactions.length,
      ),
    );
  }
}
