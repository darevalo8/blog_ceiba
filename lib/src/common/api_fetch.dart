import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'constants.dart';

final String baseUrl = getEnvironment();

class ApiBaseHelper {
  Future<dynamic> get(
      {required String url,
      Map<String, String> params = const {},
      Map<String, String> headers = const {}}) async {
    dynamic responseJson;

    try {
      final urlFull = Uri.https(baseUrl, url, params);
      final response = await http.get(urlFull, headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No hay conexión a internet');
    }
    return responseJson;
  }


  Future<dynamic> post(
      {required String url,
      Map<String, String> body = const {},
      Map<String, String> headers = const {}}) async {
    dynamic responseJson;

    try {
      final urlFull = Uri.https(baseUrl, url);
      final response = await http.post(urlFull, body: body, headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No hay conexión a internet');
    }

    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(utf8.decode(response.bodyBytes));
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Ha ocurrido un error durante la comunicación con el servidor: ${response.statusCode}');
    }
  }
}

class AppException implements Exception {
  // ignore: prefer_typing_uninitialized_variables
  final message;
  // ignore: prefer_typing_uninitialized_variables
  final _prefix;

  AppException([this.message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message, "Error: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(errorsMapping(message), "Solicitud inválida: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(errorsMapping(message), "No autorizado: ");
}

class ApiResponse<T> {
  Status status;
  T? data;
  String? message;

  

  ApiResponse.loading( this.message) : status = Status.LOADING;
  ApiResponse.completed(this.data) : status = Status.COMPLETED;
  ApiResponse.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Estado: $status\nMensaje: $message\nDatos: $data";
  }
}

// ignore: constant_identifier_names
enum Status { LOADING, COMPLETED, ERROR, INITIAL, NOTIFICATION, SUCCES }


String errorsMapping(dynamic str) {
  // String errors = '';
  Map body = json.decode(str);
  if (body.containsKey('error')){
    return body['error'];
    // body['errors'].forEach((e) {
    //   if (e.containsKey('field')) errors += e['field'] + ': ';
    //   if (e.containsKey('message')) errors += e['message'] + '\n' + '\n';
    // });
  } else {
    return 'Error no especificado';
  }
}