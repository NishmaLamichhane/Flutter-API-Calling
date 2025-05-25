import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_dart/constansts/app_constants.dart';
import 'package:todo_dart/features/home/presentation/blocs/bloc/todo_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TodoBloc>().add(FetchTodoEvent());
    return Scaffold(
      appBar: AppBar(
        title: Text("Todos"),
        actions: [
          GestureDetector(
            onTap:
                () => Navigator.of(context).pushNamed(AppRoutes.addTodoScreen),
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: BlocConsumer<TodoBloc, TodoState>(
        listener: (context, state) {
          if(state is DeleteTodoSuccessState) {
            context.read<TodoBloc>().add(FetchTodoEvent()); //refresh the list
            // Show a snackbar when todo is deleted successfully
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Todo Deleted Successfully ✅"),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
              ),
            );
          } else if (state is DeleteTodoFailState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 2),
              ),
            );
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          return BlocBuilder<TodoBloc, TodoState>(
            builder: (context, state) {
              print(state);
              if (state is FetchTodoFail) {
                return Center(child: Text(state.error));
              } else if (state is FetchTodoLoaded) {
                return ListView.builder(
                  itemBuilder: (ctx, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      child: Card(
                        child: ListTile(
                          leading: Checkbox(
                            value: state.todos[index].isCompleted,
                            onChanged: (value) {},
                          ),
                          title: Text(state.todos[index].title),
                          subtitle: Text(state.todos[index].description),
                          trailing: IconButton.filledTonal(
                            onPressed: () {
                              context.read<TodoBloc>().add(
                                DeleteTodoEvent(id: state.todos[index].id),
                              );
                            },
                            icon: Icon(Icons.delete_outline, color: Colors.red),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: state.todos.length,
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          );
        },
      ),
    );
  }
}
