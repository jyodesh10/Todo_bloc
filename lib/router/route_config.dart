import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_bloc/screens/home/bloc_home.dart';

final GoRouter goRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return BlocHome();
      },
      routes: const <RouteBase>[],
    ),
  ],
);
