import 'package:app_agendamento/core/helpers/result.dart';
import 'package:app_agendamento/features/auth/data/results/login_failed_results.dart';
import 'package:app_agendamento/features/auth/models/user.dart';

import 'auth_datasource.dart';

class AuthRepository {
  final AuthDatasource _datasource = AuthDatasource();
  User? user;

  Future<Result<LoginFailureResult, User>> login(
      {required String email, required String password}) async {
    final result = await _datasource.login(email: email, password: password);
    if (result case Failure(error: final error)) {
      print(error);
    }
    if (result case Success(object: final user)) {
      this.user = user;
    }
    return result;
  }
}
