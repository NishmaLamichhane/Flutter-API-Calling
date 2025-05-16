import 'package:get_it/get_it.dart';
import 'package:todo_dart/core/api/api_calls.dart';
import 'package:todo_dart/features/home/data/repositories/todo_repository.dart';
import 'package:todo_dart/features/home/data/sources/todo_data_source.dart';

//GetIt is a service locator for Dart and Flutter projects. 
//It allows you to register and retrieve instances of your classes easily, 
//making dependency injection straightforward.
GetIt getIt = GetIt.instance;
servicelocator(){
  // Registering the ApiCalls class as a lazy singleton.
  // This means that the instance will be created only when it's needed for the first time.
  // After that, the same instance will be used throughout the app.
  //LazySingleton is a type of singleton that creates the instance only when it is needed.
  // This is useful for classes that are expensive to create or that you don't need immediately.
  getIt.registerLazySingleton<ApiCalls>(()=>ApiCalls());
  getIt.registerLazySingleton<TodoDataSource>(()=> TodoDataSourceImpl(apicalls: getIt<ApiCalls>()));
  getIt.registerLazySingleton<TodoRepository>(()=> TodoRepositoryImpl(todoDataSource: getIt<TodoDataSource>()));
}