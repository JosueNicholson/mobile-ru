import 'dart:convert';

import 'package:http/http.dart' show Client, Response;
import 'package:mobile_ru/helpers/Response.dart';
import 'package:mobile_ru/helpers/app_exceptions.dart';

class ApiResource {
  Client http = Client();
  int _port = 0;
  String _protocol = "https";
  String _host = "";
  static String _token;

  Future<ResponseFromService> signIn() async {
    try {
      final token = await noAuthenticatedPost("authenticate", {
        "username": '',
        "password": ''
      });
      _token = token.split(" ")[1];
      return ResponseFromService(true, "sucesso");
    } on FetchDataException {
      return ResponseFromService(false, "Não foi possível obter resposta do servidor");
    }
  }

  Future<dynamic> get(String path) async {
    var responseJson;

    try {
      final response = await http.get(Uri(
          scheme: _protocol,
          host: _host,
          path: path), headers: { "Authorization": "Bearer "+_token });
      responseJson = _defaultResponse(response);
    } on PreconditionFailedException {
      throw PreconditionFailedException("Não está em horário de refeição");
    } on ConflictException {
      throw ConflictException("Você já avaliou a refeição deste horário");
    } on BadRequestException {
      throw BadRequestException("Matricula inválida");
    } on Exception {
      throw FetchDataException("Ocorreu um erro inesperado");
    }

    return responseJson;
  }

  Future<dynamic> put(String path, Map<String, dynamic> body, { bool isJson = true }) async {
    var responseJson;
    Map<String, String> headers = {
      "Authorization": "Bearer "+_token
    };

    if (isJson) {
      headers["content-type"] = "application/json";
    }

    try {
      final response = await http.put(
        Uri(
            scheme: _protocol,
            host: _host,
            path: path),
        body: isJson ? jsonEncode(body) : body,
        headers: headers,
      );
      responseJson = _defaultResponse(response);
    } on PreconditionFailedException {
      throw PreconditionFailedException("Não está em horário de refeição");
    } on ConflictException {
      throw ConflictException("Você já avaliou a refeição deste horário");
    } on BadRequestException {
      throw BadRequestException("Matricula inválida");
    } on Exception {
      throw FetchDataException("Ocorreu um erro inesperado");
    }

    return responseJson;
  }


  Future<dynamic> noAuthenticatedPost(String path, Map<String, dynamic> body, { bool isJson = true }) async {
    var responseJson;
    Map<String, String> headers = {};

    if (isJson) {
      headers["content-type"] = "application/json";
    }

    try {
      final response = await http.post(
        Uri(
            scheme: _protocol,
            host: _host,
            path: path),
        body: isJson ? jsonEncode(body) : body,
        headers: headers,
      ).timeout(Duration(seconds: 30));
      responseJson = response.body;
    } catch (exception) {
      throw FetchDataException('Has Issues on Internet Connection');
    }

    return responseJson;
  }

  dynamic _defaultResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        if(response.body.isNotEmpty) {
          return json.decode(response.body.toString());
        }
        return true;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        throw UnauthorizedException(response.body.toString());
      case 403:
        throw ForbiddenException(response.body.toString());
      case 409:
        throw ConflictException(response.body.toString());
      case 412:
        throw PreconditionFailedException(response.body.toString());
      case 500:
        throw InternalErrorException(response.body.toString());
      default:
        throw FetchDataException('Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}