import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart';
import 'package:task_manager/app.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';

import '../../splash screens/signin_page.dart';

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
  static const String _unauthorizederror = 'Unauthorized';

  static Future<NetworkResponse> getRequest({required String url}) async {
    Uri uri = Uri.parse(url);
    _logrequest(url, null, null);
    Response response = await get(uri);
    _logresponse(url, response);
    try {
      if (response.statusCode == 200) {
        final decodedjson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          body: decodedjson,
        );
      } else if (response.statusCode == 401) {
        _onUnathurize();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          message: _unauthorizederror,
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
    bool isFormlogin = false,
  }) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'token': authcontroller.accessToken ?? '',
    };
    Uri uri = Uri.parse(url);
    _logrequest(url, body, headers);
    Response response = await post(
      uri,
      headers: headers,
      body: jsonEncode(body),
    );
    _logresponse(url, response);
    try {
      if (response.statusCode == 200) {
        final decodedjson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          body: decodedjson,
        );
      } else if (response.statusCode == 401) {
        if (isFormlogin) {
          _onUnathurize();
        }
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          message: _unauthorizederror,
        );
      } else {
        final decodedjson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          message: decodedjson['data'] ?? _deferror,
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

  static void _logrequest(
    String url,
    Map<String, String>? body,
    Map<String, String>? headers,
  ) {
    debugPrint(
      '================REQUEST====================\n'
      'url:$url'
      'BODY:$body'
      'HEADERS:$headers'
      '================================================\n',
    );
  }

  static void _logresponse(String url, Response response) {
    debugPrint(
      '===============RESPONSE=====================\n'
      'url:$url'
      'STATUS CODE:${response.statusCode}'
      'BODY:${response.body}'
      '================================================\n',
    );
  }

  static Future<void> _onUnathurize() async {
    await authcontroller.removeUserData();
    Navigator.of(
      TaskManager.navigator.currentContext!,
    ).pushNamedAndRemoveUntil(SigninScreen.routeName, (route) => false);
  }
}
