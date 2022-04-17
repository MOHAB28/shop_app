import 'package:dio/dio.dart';

class DioHelpers {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
      'lang' : 'en',
    };
    return await dio.get(url, queryParameters: query).catchError((error){
      print('${error.toString()}');
    });
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    dio.options.headers = {
      'lang' : 'en',
      'Content-Type': 'application/json',
      'Authorization' : token ?? '',
    };

    return await dio
        .post(
      url,
      queryParameters: query,
      data: data,
    )
        .catchError((error) {
      print('from dio ${error.toString()}');
    });
  }

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    dio.options.headers = {
      'lang' : 'en',
      'Content-Type': 'application/json',
      'Authorization' : token ?? '',
    };

    return await dio
        .put(
      url,
      queryParameters: query,
      data: data,
    )
        .catchError((error) {
      print('from dio ${error.toString()}');
    });
  }
}
