import 'package:exam_project/core/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/blocs/income/transaction_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    BlocProvider(
      create: (context) => TransactionBloc(),
      child: const MyApp(),
    ),
  );
}
