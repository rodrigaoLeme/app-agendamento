import 'package:app_agendamento/core/flavor_config.dart';
import 'package:flutter/material.dart';

import 'core/helpers/result.dart';
import 'features/auth/data/auth_repository.dart';

void bootstrap(FlavorConfig config) {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    final AuthRepository authRepository = AuthRepository();
    final result = await authRepository.login(
        email: 'rodrigo@gmail.com', password: '123456');
    switch (result) {
      case Success(object: final user):
        print('success ${user.id}');
      case Failure(error: final error):
        print('App $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
