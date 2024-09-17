
import 'package:exam_project/core/utils/extensions/sizedbox_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/transaction.dart';
import '../../logic/blocs/income/transaction_bloc.dart';

class AddExpenseModal extends StatefulWidget {
  const AddExpenseModal({super.key});

  @override
  State<AddExpenseModal> createState() => _AddExpenseModalState();
}

class _AddExpenseModalState extends State<AddExpenseModal> {
  final _formKey = GlobalKey<FormState>();
  final descController = TextEditingController();
  final amountController = TextEditingController();
  final categoryController = TextEditingController();
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          // mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "Add an expense",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            20.height,

            /// INPUT DESCRIPTION
            TextFormField(
              controller: descController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                labelText: "Description",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Enter description";
                }
                return null;
              },
            ),
            20.height,

            /// INPUT AMOUNT
            TextFormField(
              controller: amountController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                labelText: "Amount",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Enter amount";
                }
                return null;
              },
            ),
            20.height,

            /// INPUT CATEGORY
            TextFormField(
              controller: categoryController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                labelText: "Category",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Enter category";
                }
                return null;
              },
            ),
            20.height,

            /// DATE PICKING
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${date.day}-${date.month}-${date.year}",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                TextButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      firstDate: DateTime(200),
                      lastDate: DateTime(2050),
                      initialDate: date,
                      currentDate: DateTime.now(),
                    ).then(
                          (value) {
                        setState(() {
                          date = value ?? DateTime.now();
                        });
                      },
                    );
                  },
                  child: const Text("Change date"),
                )
              ],
            ),
            20.height,
            FilledButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<TransactionBloc>().add(
                    AddTransactionEvent(
                      transaction: TransactionModel(
                        description: descController.text.trim(),
                        type: 'expense',
                        amount: double.parse(amountController.text.trim()),
                        date: date,
                        categoryTitle: categoryController.text.trim(),
                        categoryType: "expense",
                      ),
                    ),
                  );
                  descController.clear();
                  amountController.clear();
                  categoryController.clear();
                  Navigator.pop(context);
                }
              },
              child: const Text("Add expense"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    descController.dispose();
    amountController.dispose();
    categoryController.dispose();
    super.dispose();
  }
}
