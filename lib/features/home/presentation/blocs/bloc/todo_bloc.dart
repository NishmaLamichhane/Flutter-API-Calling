import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_dart/features/home/data/models/todo.dart';
import 'package:todo_dart/features/home/data/repositories/todo_repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository;
TodoBloc(this.todoRepository) : super(TodoInitial()){

    on<FetchTodoEvent>((event, emit)async{
      emit(FetchTodoLoading());
      final result = await todoRepository.fetchTodo();
      result.fold((error)=>emit(FetchTodoFail(error.errorMessage)),
       (success) => emit(FetchTodoLoaded(success)),
      );
    });
    on <AddTodoEvent>((event, emit)async{
      emit(AddTodoLoadingState());
      final result = await todoRepository.storeTodo(data: event.formData);
      result.fold((error)=>emit(AddTodoFailState(error: error.errorMessage)),
       (success) => emit(AddTodoSuccessState(message: success)),
      );
    });
  }
}
