import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/todo_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial(todoslist)) {
    on<AddTodoEvent>(
      (event, emit) {
        final newTodo = TodoModel(
            id: event.id,
            title: event.title,
            body: event.body,
            isCompleted: false);
        final todo = [...state.todos, newTodo];
        emit(state.copyWith(listTodos: todo));
        print(state);
      },
    );
    on<DeleteTodoEvent>(
      (event, emit) {
        final newTodo =
            state.todos.where((TodoModel t) => t.id != event.id).toList();
        emit(state.copyWith(listTodos: newTodo));
      },
    );

    on<UpdateTodoEvent>(
      (event, emit) {
        final todos = state.todos.map((TodoModel todo) {
          if (todo.id == event.id) {
            return TodoModel(
                id: event.id,
                body: event.body,
                title: event.title,
                isCompleted: event.isCompleted);
          }
          return todo;
        }).toList();

        emit(state.copyWith(listTodos: todos));

        if (emit.isDone) {
          log('Updated ');
        }
      },
    );

    // _addTodo(AddTodoEvent event, Emitter<TodoState> emit) {
    //   final newTodo = TodoModel(id: 1, title: event.title, body: event.body);
    //   final todo = [...state.todos, newTodo];
    //   emit(state.copyWith(listTodos: todo));
    // }
  }
}
