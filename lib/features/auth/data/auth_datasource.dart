import 'package:app_agendamento/core/helpers/result.dart';
import 'package:app_agendamento/core/helpers/token_interceptor.dart';
import 'package:app_agendamento/features/auth/data/results/login_failed_results.dart';
import 'package:app_agendamento/features/auth/models/user.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AuthDatasource {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://parseapi.back4app.com/functions',
      headers: {
        'X-Parse-Application-Id': 'UAuYMjHexZiNF05G1C6TWRgqdUjXLwU4kTPabKlo',
        'X-Parse-REST-API-Key': 'nzJorIgzdBUo3xFVKxPkLnJboW1Kojvl3EDCXr2d'
      },
    ),
  )..interceptors.addAll(
      [
        TokenInterceptor(),
        PrettyDioLogger(requestBody: true, requestHeader: true),
      ],
    );

  Future<Result<LoginFailureResult, User>> login(
      {required String email, required String password}) async {
    try {
      final response = await _dio.post(
        '/v1-sign-in',
        data: {
          'email': email,
          'password': password,
        },
      );
      return Success(User.fromMap(response.data['result']));
    } on DioException catch (e) {
      if (e.type == DioExceptionType.unknown) {
        return const Failure(LoginFailureResult.offline);
      } else if (e.response?.statusCode == 404) {
        return const Failure(LoginFailureResult.invalidCredentials);
      }
      return const Failure(LoginFailureResult.unknowError);
    } catch (_) {
      return const Failure(LoginFailureResult.unknowError);
    }
  }
}
