import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:todo_app/Database/todoDatabase.dart';
import 'package:todo_app/Screens/Model/todoModel.dart';
import 'package:todo_app/Screens/todo_bloc.dart';
import 'package:todo_app/Screens/todo_event.dart';
import 'package:todo_app/Screens/todo_state.dart';

class TodoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text('Todo List'),
      ),
      body: BlocProvider(
        create: (context) => TodoBloc(TodoDatabase())..add(LoadTodos()),
        child: TodoList(),
      ),
    );
  }
}

class TodoList extends StatelessWidget {
  final namecontroller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state is TodoLoadSuccess) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
                child: Container(
                  child: TextField(
                    controller: namecontroller,
                    decoration: InputDecoration(
                        labelText: 'Enter your task',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: 15, left: 15, top: 20, bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          final title = namecontroller.text.trim();
                          if (title.isNotEmpty) {
                            context.read<TodoBloc>().add(AddTodo(Todo(
                                id: 0,
                                title: namecontroller.text,
                                isCompleted: 0)));
                            namecontroller.clear();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please enter a task'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.brown,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  blurRadius: 5.0,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                "Add",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              state.todos.length > 0
                  ? Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.todos.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final todo = state.todos[index];
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Container(
                              margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade400,
                                    blurRadius: 5.0,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                title: Text(todo.title),
                                leading: Checkbox(
                                  value: todo.isCompleted == 0 ? false : true,
                                  activeColor: Colors.brown,
                                  onChanged: (val) {
                                    var todos = Todo(
                                        id: todo.id,
                                        title: todo.title,
                                        isCompleted: val == true ? 1 : 0);
                                    context.read<TodoBloc>().add(
                                          UpdateTodo(todos),
                                        );
                                  },
                                ),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete),
                                  color: Colors.red,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext contexts) {
                                        return delete_Dailog(context, () {
                                          context
                                              .read<TodoBloc>()
                                              .add(DeleteTodo(todo));
                                        });
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(child: Text("No task found")),
                        ],
                      ),
                    )
            ],
          );
        } else if (state is TodoLoadFailure) {
          return Column(
            children: [
              Center(
                child: Text('Failed to load todos: ${state.error}'),
              ),
              InkWell(
                onTap: () {
                  context.read<TodoBloc>().add(
                      AddTodo(Todo(id: 1, title: 'title', isCompleted: 0)));
                },
                child: Container(
                  height: 50,
                  width: 50,
                  color: Colors.yellow,
                ),
              )
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  delete_Dailog(context, Function deletes) {
    return AlertDialog(
      title: Text('Delete Task'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Are you sure want to delete this task ?'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Yes'),
          onPressed: () {
            Navigator.of(context).pop();
            deletes();
          },
        ),
        TextButton(
          child: Text('No'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
