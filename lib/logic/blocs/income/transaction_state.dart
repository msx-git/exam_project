part of 'transaction_bloc.dart';

sealed class TransactionState {}

final class TransactionInitialState extends TransactionState {}

final class TransactionLoadingState extends TransactionState {}

final class TransactionLoadedState extends TransactionState {
  final List<TransactionModel> transactions;

  TransactionLoadedState({required this.transactions});
}

final class TransactionErrorState extends TransactionState {
  final String errorMessage;

  TransactionErrorState({required this.errorMessage});
}
