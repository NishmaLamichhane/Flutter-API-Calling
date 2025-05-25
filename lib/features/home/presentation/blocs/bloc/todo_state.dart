part of 'todo_bloc.dart';

@immutable
sealed class TodoState {}

final class TodoInitial extends TodoState {}

// This state is emitted when the todo list is being loaded.
class FetchTodoLoading extends TodoState {}

/// This state is emitted when the todo list is successfully loaded.
class FetchTodoLoaded extends TodoState {
  final List<Todo> todos;
  FetchTodoLoaded(this.todos);
}
//mero api call huda k k state aauna sakxa define garne->loading, success, fail
/// This state is emitted when there is an error loading the todo list.
class FetchTodoFail extends TodoState {
  final String error;
  FetchTodoFail(this.error);
}
class AddTodoLoadingState extends TodoState {

}
class AddTodoSuccessState extends TodoState {
  final String message;
  AddTodoSuccessState({required this.message});
}
class AddTodoFailState extends TodoState {
  final String error;
  AddTodoFailState({required this.error});
}
class DeleteTodoLoadingState extends TodoState {

}
class DeleteTodoSuccessState extends TodoState {
  final String message;
  DeleteTodoSuccessState({required this.message});
}
class DeleteTodoFailState extends TodoState {
  final String error;
  DeleteTodoFailState({required this.error});
}