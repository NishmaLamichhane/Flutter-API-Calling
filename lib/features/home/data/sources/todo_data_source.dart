import 'package:todo_dart/core/api/api_calls.dart';
import 'package:todo_dart/features/home/data/models/todo.dart';

abstract class TodoDataSource {
  Future<List<Todo>> fetchTodo();
//Adding delete method
Future<String> deleteTodo({required int id}) async {
    return 'Todo deleted';
  }
  storeTodo({required Map<String, dynamic> data}) {}
}

class TodoDataSourceImpl extends TodoDataSource {
  final ApiCalls apicalls;
  TodoDataSourceImpl({required this.apicalls});
  @override
  Future<List<Todo>> fetchTodo() async {
    final result = await apicalls.getData(endpoint: 'todo') as List;
    return result.map((todo) => Todo.fromMap(todo)).toList();
  }

  @override
  Future<String> storeTodo({required Map<String, dynamic> data}) async {
    final response = await apicalls.sendData(endpoint: 'todo', data: data);
    return response['message'];
  }
  @override
  Future<String> deleteTodo({required int id}) async {
    final response = await apicalls.deleteData(endpoint: 'todo/$id');
    return response['message'];
  }
}
