part of 'todo_bloc.dart';

class TodoState extends Equatable {
  List<TodoModel> todos;

  TodoState(this.todos);

  @override
  List<Object> get props => [todos];

  TodoState copyWith({
    required List<TodoModel>? listTodos,
  }) {
    return TodoState(
      listTodos ?? todos,
    );
  }
}

class TodoInitial extends TodoState {
  TodoInitial(super.todos);
}
