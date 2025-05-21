import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_dart/features/home/presentation/blocs/bloc/todo_bloc.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final _formKey = GlobalKey<FormState>();
  String? title;
  String? description;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Todo")),
      body: BlocListener<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is AddTodoSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          }
          if (state is AddTodoFailState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          }
          // TODO: implement listener
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Title"),
                TextFormField(
                  onSaved: (newValue) {
                    setState(() {
                      title = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a title";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Write the title",
                    label: Text("Title"),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                ),
                Text("Description"),
                TextFormField(
                  onSaved: (newValue) {
                    setState(() {
                      description = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a title";
                    }
                    return null;
                  },
                  minLines: 6,
                  maxLines: 10,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Write the description",
                    label: Text("Description"),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                ),
                Row(
                  spacing: 20,
                  children: [
                    BlocBuilder<TodoBloc, TodoState>(
                      builder: (context, state) {
                        return FilledButton.tonal(
                          onPressed: () async {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            _formKey.currentState!.save();
                            final Map<String, dynamic> formData = {
                              "title": title,
                              "description": description,
                            };
print("add toodo: $state");
                            context.read<TodoBloc>().add(AddTodoEvent(formData: formData));
print("after add toodo: $state");
                            
                           
                             context.read<TodoBloc>().add(FetchTodoEvent());
                           
                            Navigator.of(context).pop();
                          },

                          child: Text("Add"),
                        );
                      },
                    ),
                    FilledButton.tonal(
                      onPressed: () {},
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white),
                      ),

                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
