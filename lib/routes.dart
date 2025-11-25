import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'views/home_view.dart';
import 'views/detail_view.dart';
import 'models/person.dart';

class AppRouter {
  static GoRouter router(BuildContext context) {
    return GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => const HomeView(),
        ),
        GoRoute(
          path: '/detail',
          name: 'detail',
          builder: (context, state) {
            final person = state.extra as Person;
            return DetailView(person: person);
          },
        ),
      ],
    );
  }
}
