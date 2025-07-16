import 'dart:convert';

import 'package:http/http.dart';

class NetworkResponse {
  final bool isSuccess;
  final int statusCode;
  final String? message;
  final Map<String, dynamic>? body;
  NetworkResponse({
    required this.isSuccess,
    this.body,
    required this.statusCode,
    this.message,
  });
}

class Networkcaller {
  static const String _deferror = 'Something went wrong';
  static Future<NetworkResponse> getRequest({required String url}) async {
    Uri uri = Uri.parse(url);
    Response response = await get(uri);
    try {
      if (response.statusCode == 200) {
        final decodedjson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          body: decodedjson,
        );
      } else {
        final decodedjson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          message: decodedjson['error'] ?? _deferror,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        message: _deferror,
      );
    }
  }

  static Future<NetworkResponse> postRequest({
    required String url,
    required Map<String, String> body,
  }) async {
    Uri uri = Uri.parse(url);
    Response response = await post(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body));
    try {
      if (response.statusCode == 200) {
        final decodedjson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          body: decodedjson,
        );
      } else {
        final decodedjson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          message: decodedjson['error'] ?? _deferror,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        message: _deferror,
      );
    }
  }
}
