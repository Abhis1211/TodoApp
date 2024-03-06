import 'package:equatable/equatable.dart';
import 'Model/todoModel.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoInitial extends TodoState {}

class TodoLoadSuccess extends TodoState {
  final List<Todo> todos;

  const TodoLoadSuccess([this.todos = const []]);

  @override
  List<Object> get props => [todos];
}

class TodoLoadFailure extends TodoState {
  final String error;

  const TodoLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}

class TodoOperationFailure extends TodoState {
  final String error;

  const TodoOperationFailure(this.error);

  @override
  List<Object> get props => [error];
}
