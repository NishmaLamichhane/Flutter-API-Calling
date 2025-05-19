import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: Text("Add Todo"),
      ),
      body: Padding(
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
              onSaved:(newValue){
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
              onSaved:(newValue){
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
                FilledButton.tonal(
                  onPressed: () {
                    if(!_formKey.currentState!.validate()){
                      return;
                    }
                    _formKey.currentState!.save();
                    final Map<String, dynamic> formData = {
                      "title": title,
                      "description": description,
                    };
                  },
                  child: Text("Add"),
                ),
                FilledButton.tonal(
                  onPressed: () {},
                 child: Text("Cancel",
                    style: TextStyle(color: Colors.white),
                  ),

                  style: FilledButton.styleFrom(backgroundColor: Colors.red),
                )
              ],
            )
          ],
        )),
      ),
    );
  }
}