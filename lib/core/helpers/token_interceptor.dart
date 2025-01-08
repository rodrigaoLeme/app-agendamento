import 'package:app_agendamento/features/auth/data/auth_repository.dart';
import 'package:dio/dio.dart';

class TokenInterceptor extends Interceptor {
  final AuthRepository authRepository = AuthRepository();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['X-Parse-Session-Token'] = authRepository.user?.token;
    super.onRequest(options, handler);
  }
}
