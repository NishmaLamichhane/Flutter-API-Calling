import 'package:dartz/dartz.dart';
import 'package:todo_dart/core/api/api_erorr.dart';
import 'package:todo_dart/features/home/data/models/todo.dart';
import 'package:todo_dart/features/home/data/sources/todo_data_source.dart';

abstract class TodoRepository {
  Future<Either<ApiErorr,List<Todo>>> fetchTodo();
  Future<Either<ApiErorr,String>> storeTodo({required Map<String, dynamic> data});
  Future<Either<ApiErorr,String>> deleteTodo({required int id});
}
class TodoRepositoryImpl extends TodoRepository {
  final TodoDataSource todoDataSource;

  TodoRepositoryImpl({required this.todoDataSource});
//Left side is the error and right side is the success
  @override
  Future<Either<ApiErorr, List<Todo>>> fetchTodo() async {
    try {
      final result = await todoDataSource.fetchTodo();
      return right(result);
    } catch (e) {
      return left(ApiErorr(errorMessage: e.toString()));
    }
  }
  @override
  Future<Either<ApiErorr, String>> storeTodo({required Map<String, dynamic> data}) async {
    try {
      final result = await todoDataSource.storeTodo(data: data);
      return right(result);
    } catch (e) {
      return left(ApiErorr(errorMessage: e.toString()));
    }
  }
  @override
  Future<Either<ApiErorr, String>> deleteTodo({required int id}) async {
    try {
      final result = await todoDataSource.deleteTodo(id: id);
      return right(result);
    } catch (e) {
      return left(ApiErorr(errorMessage: e.toString()));
    }
  }
}