import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/theme_cubit/theme_cubit.dart';
import '../../bloc/todo_bloc/todo_bloc.dart';

class BlocHome extends StatelessWidget {
  BlocHome({Key? key}) : super(key: key);

  final title = TextEditingController();
  final body = TextEditingController();

  clear() {
    title.clear();
    body.clear();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('BLOC TODO'),
        backgroundColor: Colors.blueAccent,
        actions: [
          BlocBuilder<ThemeCubit, bool>(
            builder: (context, state) {
              return Switch(
                value: state,
                activeColor: Colors.amber,
                onChanged: (value) {
                  context.read<ThemeCubit>().darkmode();
                },
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          BlocBuilder<TodoBloc, TodoState>(
            builder: (context, state) {
              return Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10,
                          color: Theme.of(context).shadowColor.withOpacity(0.4),
                          offset: const Offset(0, 2))
                    ]),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Text('Todo Length: ${state.todos.length}'),
                    state.todos.isEmpty
                        ? const Text('no data')
                        : Center(
                            child: ListView.builder(
                            itemCount: state.todos.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => CheckboxListTile(
                              value: state.todos[index].isCompleted,
                              onChanged: (value) {
                                context.read<TodoBloc>().add(UpdateTodoEvent(
                                    state.todos[index].id,
                                    state.todos[index].title,
                                    state.todos[index].body,
                                    value!));
                              },
                              title: Row(
                                children: [
                                  Text(
                                    '${index + 1}. ',
                                    style: textTheme.bodyLarge,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    context
                                        .watch<TodoBloc>()
                                        .state
                                        .todos[index]
                                        .title,
                                    style: textTheme.bodyLarge,
                                  ),
                                  const Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        title.text = state.todos[index].title;
                                        body.text = state.todos[index].body;
                                        _buildBottomSheet(
                                          context,
                                          () {
                                            // BlocProvider.of<TodoBloc>(context).add(
                                            //     AddTodoEvent(title.text, body.text));
                                            context.read<TodoBloc>().add(
                                                UpdateTodoEvent(
                                                    state.todos[index].id,
                                                    title.text,
                                                    body.text,
                                                    false));
                                            clear();
                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                      icon: const Icon(Icons.edit)),
                                  IconButton(
                                      onPressed: () {
                                        context.read<TodoBloc>().add(
                                            DeleteTodoEvent(
                                                state.todos[index].id));
                                      },
                                      icon: const Icon(Icons.delete)),
                                ],
                              ),
                            ),
                          )),
                    IconButton(
                        onPressed: () {
                          _buildBottomSheet(
                            context,
                            () {
                              // BlocProvider.of<TodoBloc>(context).add(
                              //     AddTodoEvent(title.text, body.text));
                              context.read<TodoBloc>().add(AddTodoEvent(
                                  state.todos.length + 1,
                                  title.text,
                                  body.text,
                                  false));
                              clear();
                              Navigator.pop(context);
                            },
                          );
                        },
                        icon: const Icon(Icons.add))
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  _buildBottomSheet(context, ontap) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(15.0)
            .copyWith(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: title,
              decoration: const InputDecoration(hintText: 'Title'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: body,
              decoration: const InputDecoration(hintText: 'Body'),
            ),
            const SizedBox(
              height: 10,
            ),
            MaterialButton(
              onPressed: ontap,
              child: const Text('Submit'),
            )
          ],
        ),
      ),
    );
  }
}
