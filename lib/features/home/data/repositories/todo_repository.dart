import 'package:dartz/dartz.dart';
import 'package:todo_dart/core/api/api_erorr.dart';
import 'package:todo_dart/features/home/data/models/todo.dart';
import 'package:todo_dart/features/home/data/sources/todo_data_source.dart';

abstract class TodoRepository {
  Future<Either<ApiErorr,List<Todo>>> fetchTodo();
}
class TodoRepositoryImpl extends TodoRepository {
  final TodoDataSource todoDataSource;

  TodoRepositoryImpl({required this.todoDataSource});

  @override
  Future<Either<ApiErorr, List<Todo>>> fetchTodo() async {
    try {
      final result = await todoDataSource.fetchTodo();
      return Right(result);
    } catch (e) {
      return Left(ApiErorr(errorMessage: e.toString()));
    }
  }
}