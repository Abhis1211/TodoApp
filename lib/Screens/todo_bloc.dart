import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:todo_app/Database/todoDatabase.dart';
import 'package:todo_app/Screens/todo_event.dart';
import 'package:todo_app/Screens/todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoDatabase repository;

  TodoBloc(this.repository) : super(TodoInitial());

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    log("Aaa" + event.toString());
    if (event is LoadTodos) {
      yield* _mapLoadTodosToState();
    } else if (event is AddTodo) {
      yield* _mapAddTodoToState(event);
    } else if (event is UpdateTodo) {
      yield* _mapUpdateTodoToState(event);
    } else if (event is DeleteTodo) {
      yield* _mapDeleteTodoToState(event);
    }
  }

  Stream<TodoState> _mapLoadTodosToState() async* {
    log("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
    try {
      final todos = await repository.getTodos();
      print("TODO LIST==> " + todos.toString());
      yield TodoLoadSuccess(todos);
    } catch (e) {
      log("TodoLoadFailure" + e.toString());
      yield TodoLoadFailure("Failed to load todos");
    }
  }

  Stream<TodoState> _mapAddTodoToState(AddTodo event) async* {
    log("enter" + event.todo.title.toString());
    try {
      await repository.addTodo(event.todo);
      yield* _mapLoadTodosToState();
    } catch (e) {
      log("Failed to add todo ==> " + e.toString());
      yield TodoLoadFailure("Failed to add todo");
    }
  }

  Stream<TodoState> _mapUpdateTodoToState(UpdateTodo event) async* {
    try {
      await repository.updateTodo(event.updatedTodo);
      yield* _mapLoadTodosToState();
    } catch (e) {
      yield TodoLoadFailure("Failed to update todo");
    }
  }

  Stream<TodoState> _mapDeleteTodoToState(DeleteTodo event) async* {
    try {
      await repository.deleteTodo(event.todo);
      yield* _mapLoadTodosToState();
    } catch (e) {
      yield TodoLoadFailure("Failed to delete todo");
    }
  }
}
