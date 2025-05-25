part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}
class FetchTodoEvent extends TodoEvent{}
class AddTodoEvent extends TodoEvent {
  final Map<String, dynamic> formData;
  AddTodoEvent({required this.formData});
}
class DeleteTodoEvent extends TodoEvent {
  final int id;
  DeleteTodoEvent({required this.id});
}