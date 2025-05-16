import 'package:todo_dart/core/api/api_calls.dart';
import 'package:todo_dart/features/home/data/models/todo.dart';

abstract class TodoDataSource {
 Future<List<Todo>> fetchTodo();
}
class TodoDataSourceImpl extends TodoDataSource{
  final ApiCalls apicalls;
  TodoDataSourceImpl({ required this.apicalls});
  @override
  Future<List<Todo>> fetchTodo() async{
  final result =await apicalls.getData(endpoint: 'todo')as List;
  return result.map((todo)=>Todo.fromMap(todo)).toList();
  }
}
