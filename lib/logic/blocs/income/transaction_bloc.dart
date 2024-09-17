import 'package:bloc/bloc.dart';
import 'package:exam_project/data/services/transaction_db_service.dart';

import '../../../data/models/transaction.dart';

part 'transaction_event.dart';

part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final db = TransactionDbService();

  TransactionBloc() : super(TransactionInitialState()) {
    on<GetAllTransactions>(_onGetAllTransactions);
    on<AddTransactionEvent>(_onAddTransaction);
    on<DeleteTransactionEvent>(_onDeleteTransaction);
    on<UpdateTransactionEvent>(_onUpdateTransaction);
  }

  /// GET ALL Transactions EVENT
  void _onGetAllTransactions(event, emit) async {
    emit(TransactionLoadingState());
    try {
      emit(TransactionLoadedState(transactions: await db.getAllTransactions()));
    } catch (e) {
      emit(TransactionErrorState(errorMessage: e.toString()));
    }
  }

  /// ADD Transaction EVENT
  void _onAddTransaction(AddTransactionEvent event, emit) async {
    emit(TransactionLoadingState());
    try {
      await db.addTransaction(income: event.transaction);
      add(GetAllTransactions());
    } catch (e) {
      emit(TransactionErrorState(errorMessage: e.toString()));
    }
  }

  /// DELETE Transaction EVENT
  void _onDeleteTransaction(DeleteTransactionEvent event, emit) async {
    emit(TransactionLoadingState());
    try {
      await db.deleteTransaction(event.id);
      add(GetAllTransactions());
    } catch (e) {
      emit(TransactionErrorState(errorMessage: e.toString()));
    }
  }

  /// UPDATE Transaction EVENT
  void _onUpdateTransaction(UpdateTransactionEvent event, emit) async {
    emit(TransactionLoadingState());
    try {
      await db.updateTransaction(event.id, event.transaction);
      add(GetAllTransactions());
    } catch (e) {
      emit(TransactionErrorState(errorMessage: e.toString()));
    }
  }
}
