part of 'transaction_bloc.dart';

sealed class TransactionEvent {}

final class GetAllTransactions extends TransactionEvent {}

final class AddTransactionEvent extends TransactionEvent {
  final TransactionModel transaction;

  AddTransactionEvent({required this.transaction});
}

final class DeleteTransactionEvent extends TransactionEvent {
  final int id;

  DeleteTransactionEvent({required this.id});
}

final class UpdateTransactionEvent extends TransactionEvent {
  final int id;
  final TransactionModel transaction;

  UpdateTransactionEvent({required this.id, required this.transaction});
}
