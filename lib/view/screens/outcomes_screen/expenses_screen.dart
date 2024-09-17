import 'package:exam_project/data/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/blocs/income/transaction_bloc.dart';
import '../../widgets/add_expense.dart';

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
      ),
      body: BlocBuilder<TransactionBloc, TransactionState>(
        bloc: context.read<TransactionBloc>()..add(GetAllTransactions()),
        builder: (context, state) {
          if (state is TransactionLoadingState ||
              state is TransactionInitialState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TransactionErrorState) {
            return Center(child: Text(state.errorMessage));
          }
          final expense = (state as TransactionLoadedState)
              .transactions
              .where((element) => element.categoryType == 'expense')
              .toList();
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: expense.length,
                  itemBuilder: (context, index) {
                    final income = expense[index];
                    return ListTile(
                      title: Text(income.description),
                      subtitle: Text(income.amount.toString()),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              context.read<TransactionBloc>().add(
                                    UpdateTransactionEvent(
                                      id: int.parse(income.id!),
                                      transaction: TransactionModel(
                                        description: "New description",
                                        type: 'outcome',
                                        amount: 15.0,
                                        date: DateTime.now(),
                                        categoryTitle: "saedfs",
                                        categoryType: "outcome",
                                      ),
                                    ),
                                  );
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              context.read<TransactionBloc>().add(
                                    DeleteTransactionEvent(
                                      id: int.parse(income.id!),
                                    ),
                                  );
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            useSafeArea: true,
            builder: (context) {
              return const AddExpenseModal();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
