import 'package:dio/dio.dart';
import 'package:proypet/config/global_variables.dart';
import 'package:proypet/src/utils/preferencias_usuario/preferencias_usuario.dart';

class AuthProvider {
  final _url = urlApi;
  final _prefs = new PreferenciasUsuario();

  Dio dio = new Dio();

  Future<int> loginGoogle(
    String name,
    String lastname,
    String email,
    String fbId,
    String accessToken,
  ) async {
    final url = '$_url/login/google';

    final loginData = {
      "first_name": name,
      "last_name": lastname,
      "email": email,
      "social_id": fbId,
      "access_token": accessToken
    };

    Response response;
    response = await dio.post(url, data: loginData);

    if (response.statusCode == 200) {
      _prefs.token = response.data['token'];
      _prefs.verify = response.data['verify'];

      return response.statusCode;
    }

    return response.statusCode;
  }

  Future<int> loginFb(
    String name,
    String lastname,
    String email,
    String fbId,
    String accessToken,
  ) async {
    final url = '$_url/login/facebook';

    try {
      final loginData = {
        "first_name": name,
        "last_name": lastname,
        "email": email,
        "social_id": fbId,
        "access_token": accessToken
      };

      Response response;
      response = await dio.post(url, data: loginData);

      if (response.statusCode == 200) {
        _prefs.token = response.data['token'];
        _prefs.verify = response.data['verify'];

        return response.statusCode;
      }
      // else if (response.statusCode == 401) return response.statusCode;
      return 401;
    } catch (ex) {
      return 500;
    }
  }

  Future<Map<String, dynamic>> loginToken(String email, String password) async {
    final url = '$_url/login';
    try {
      final loginData = {"email": email, "password": password};
      Response response;
      response = await dio.post(url, data: loginData);

      var jsonRespuesta;

      if (response.statusCode == 200) {
        _prefs.token = response.data['token'];
        _prefs.verify = response.data['verify'];

        jsonRespuesta = {'code': 200, 'token': response.data['token']};
      } else if (response.statusCode == 401) {
        jsonRespuesta = {'code': 401, 'message': response.data['message']};
      }
      return jsonRespuesta;
    } catch (ex) {
      return {'code': 500, 'message': 'Usuario o clave incorrecta'};
    }
  }

  Future<void> sendTokenFire(String fireToken) async {
    final url = '$_url/firebase';
    final fireData = {"token": fireToken};
    await dio.post(url,
        data: fireData, options: Options(headers: headersToken()));
  }

  Future<void> logOut() async {
    final url = '$_url/logout';
    await dio.post(url, options: Options(headers: headersToken()));
  }

  Future<int> forgotPassword(String email) async {
    final url = '$_url/password/reset';

    final emailData = {"email": email};
    Response response;
    response = await dio.post(url, data: emailData);
    return response.statusCode;
  }

  Future<int> registerUser(
      String name, String lastname, String email, String password) async {
    final url = '$_url/register';
    try {
      final userData = {
        "name": name,
        "lastname": lastname,
        "email": email,
        "password": password
      };
      Response response;
      response = await dio.post(url, data: userData);

      return response.statusCode;
    } catch (ex) {
      return 0;
    }
  }
}