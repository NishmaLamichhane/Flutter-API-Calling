import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_dart/features/home/presentation/blocs/bloc/todo_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final todoBloc=context.read<TodoBloc>().add(FetchTodoEvent());
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is FetchTodoFail) {
            return Center(child: Text(state.error));
          } else if (state is FetchTodoLoaded) {
            return Center(child: Text("$state.todo.length)"));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
