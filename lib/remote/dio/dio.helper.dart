
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Diohelper {
  static Dio dio;

  static Future<void> init() async {
    dio = await Dio(
      BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/',
          receiveDataWhenStatusError: true,
          ),
    );
  }

  static Future<Response> getdata({
    @required String url,
    Map<String, dynamic> query,
    String lang = 'en',
    String token,
  }) async {
    dio.options.headers={
      'Content-Type': 'application/json',
      'lang':lang??'ar',
      'Authorization': token??'',
    };
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    @required String url,
    Map<String, dynamic> query,
    Map<String, dynamic> data,
    String lang ='en',
    String token,
}
  ) async {
    dio.options.headers={
      'Content-Type': 'application/json',
      'lang':lang??'ar',
      'Authorization': token??'',
    };
    return dio.post(url, data: data,queryParameters: query,);
  }
  static Future<Response> putData({
    @required String url,
    Map<String, dynamic> query,
    @required Map<String, dynamic> data,
    String lang = 'en',
    String token,
}
  ) async {
    dio.options.headers={
      'Content-Type': 'application/json',
      'lang':lang??'ar',
      'Authorization': token??'',
    };
    return dio.put(url,data: data,queryParameters: query,);
  }
}
