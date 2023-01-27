part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class TodoEventStartedEvent extends TodoEvent {
  List<TodoModel> todos;
  TodoEventStartedEvent(this.todos);

  @override
  List<Object> get props => [todos];
}

class AddTodoEvent extends TodoEvent {
  int id;
  String title;
  String body;
  bool isCompleted;
  AddTodoEvent(this.id, this.title, this.body, this.isCompleted);

  @override
  List<Object> get props => [title, body];
}

class DeleteTodoEvent extends TodoEvent {
  int id;

  DeleteTodoEvent(this.id);

  @override
  List<Object> get props => [id];
}

class UpdateTodoEvent extends TodoEvent {
  int id;
  String title;
  String body;
  bool isCompleted;

  UpdateTodoEvent(this.id, this.title, this.body, this.isCompleted);

  @override
  List<Object> get props => [id, title, body];
}
