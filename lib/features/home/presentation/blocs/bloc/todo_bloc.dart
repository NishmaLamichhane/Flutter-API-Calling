import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_dart/features/home/data/models/todo.dart';
import 'package:todo_dart/features/home/data/repositories/todo_repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository;
  TodoBloc(this.todoRepository) : super(TodoInitial()) {
    //emit is like returning the state
    on<FetchTodoEvent>((event, emit) async {
      //suruma laoding aaaunu parxa so emit ley loading state return garxa
      emit(FetchTodoLoading());
      final result = await todoRepository.fetchTodo();
      result.fold(
        (error) => emit(FetchTodoFail(error.errorMessage)),
        (success) => emit(FetchTodoLoaded(success)),
      );
    });

    on<AddTodoEvent>((event, emit) async {
      emit(AddTodoLoadingState());
      //todo repository ma gayera data send garxa
      //todo repository bata data aauxa
      //todo repository bata data aaune bela ma success ya fail state aauxa
      final result = await todoRepository.storeTodo(data: event.formData);
      result.fold(
        //left side ma error aaune bela ma fail state aauxa in UI
        //right side ma success aaune bela ma success state aauxa in UI
        (error) => emit(AddTodoFailState(error: error.errorMessage)),
        (success) => emit(AddTodoSuccessState(message: success)),
      );
    });
    on<DeleteTodoEvent>((event, emit) async {
      emit(DeleteTodoLoadingState());
      final result = await todoRepository.deleteTodo(id: event.id);
      result.fold(
        (error) => emit(DeleteTodoFailState(error: error.errorMessage)),
        (success) => emit(DeleteTodoSuccessState(message: success)),
      );
    });
  }
}

//bloc listener le event ko state sunxa ani UI ma change garna sakxa
//bloc builder le event ko state sunxa ani UI ma change garna sakxa[loading, success, fail]hudha k dhekhaune
//bloc consumer le [listener + builder] ko kam garxa
