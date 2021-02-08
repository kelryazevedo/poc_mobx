import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

import '../app_config.dart';

enum HttpMethod { GET, POST, PUT, PATCH, DELETE }

class NetworkService {
  static Dio _dio;

  static BaseOptions _baseOptions = new BaseOptions(
    baseUrl: AppConfig.getInstance().apiBaseUrl,
    connectTimeout: AppConfig.getInstance().timeout ?? 60000,
    receiveTimeout: AppConfig.getInstance().timeout ?? 60000,
    sendTimeout: AppConfig.getInstance().timeout ?? 60000,
  );

  // NetworkService() {
  //   this._init();
  // }

  /// ==========================================================
  /// One-time initialization
  ///
  ///
  ///
  factory NetworkService() => _instance;
  static final _instance = NetworkService._internal();

  static NetworkService get instance => NetworkService._instance;

  NetworkService._internal() {
    this._init();
  }

  _init() {
    print('NetworkService init: ${AppConfig.getInstance().apiBaseUrl}');
    if (_dio == null) {
      _dio = Dio(_baseOptions);
    }
  }

  addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }

  /// ==========================================================
  /// Requests
  ///

  Future<dynamic> request(HttpMethod method, String endpoint,
      {Map<String, dynamic> headers,
        body,
        @required bool ignoreInterceptor}) async {
    dynamic response;

    try {
      if (method == HttpMethod.GET) {
        response = await this._get(endpoint,
            headers: headers, ignoreInterceptor: ignoreInterceptor);
      } else if (method == HttpMethod.POST) {
        response = await this._post(endpoint,
            body: body, headers: headers, ignoreInterceptor: ignoreInterceptor);
      } else if (method == HttpMethod.PUT) {
        response = await this._put(endpoint,
            body: body, headers: headers, ignoreInterceptor: ignoreInterceptor);
      } else if (method == HttpMethod.PATCH) {
        response = await this._patch(endpoint,
            body: body, headers: headers, ignoreInterceptor: ignoreInterceptor);
      } else if (method == HttpMethod.DELETE) {
        response = await this._delete(endpoint,
            body: body, headers: headers, ignoreInterceptor: ignoreInterceptor);
      } else {
        print('HttpMethod desconhecido!');
      }
    } catch (e) {
      print("Exception Request => ($method) => $endpoint");
      if (body != null) print('Exception Body => ${jsonEncode(body) ?? ''}');
      print('Exception Headers => ${e.request.headers}');
      print('Exception => ${e.toString()}');

      if (e is DioError) {
        var dioError = e;
        print('Exception Dio => ${dioError.message}');
        String message = dioError?.response?.data['message'];
        if (message != null) {
          throw new Exception(message);
        } else {
          throw new Exception(
              'Erro desconhecido! Entre em contato com um administrador do sistema.');
        }
      } else {
        throw new Exception(
            'Não foi possível concluir sua chamada! Tente novamente mais tarde.');
      }
    }

    return response;
  }

  Future<dynamic> _get(String endpoint,
      {Map<String, dynamic> headers, bool ignoreInterceptor = false}) async {
    if (!await this.isConnected()) {
      throw new Exception('Verifique sua conexão!');
    }

    Response response = await _dio.get(
      endpoint,
      options: await this._getCustomConfig(headers, ignoreInterceptor),
    );

    return this._generateResponse(response);
  }

  Future<dynamic> _post(String endpoint,
      {Map<String, dynamic> headers,
        body,
        bool ignoreInterceptor = false}) async {
    if (!await this.isConnected()) {
      throw new Exception('Verifique sua conexão!');
    }

    Response response = await _dio.post(
      endpoint,
      data: body,
      options: await this._getCustomConfig(headers, ignoreInterceptor),
    );

    return this._generateResponse(response);
  }

  Future<dynamic> _put(String endpoint,
      {Map<String, dynamic> headers,
        body,
        bool ignoreInterceptor = false}) async {
    if (!await this.isConnected()) {
      throw new Exception('Verifique sua conexão!');
    }

    Response response = await _dio.put(
      endpoint,
      data: body,
      options: await this._getCustomConfig(headers, ignoreInterceptor),
    );
    return this._generateResponse(response);
  }

  Future<dynamic> _patch(String endpoint,
      {Map<String, dynamic> headers,
        body,
        bool ignoreInterceptor = false}) async {
    if (!await this.isConnected()) {
      throw new Exception('Verifique sua conexão!');
    }

    Response response = await _dio.patch(
      endpoint,
      data: body,
      options: await this._getCustomConfig(headers, ignoreInterceptor),
    );
    return this._generateResponse(response);
  }

  Future<dynamic> _delete(String endpoint,
      {Map headers, body, bool ignoreInterceptor = false}) async {
    if (!await this.isConnected()) {
      throw new Exception('Verifique sua conexão!');
    }

    Response response = await _dio.delete(
      endpoint,
      data: body,
      options: await this._getCustomConfig(headers, ignoreInterceptor),
    );
    return this._generateResponse(response);
  }

  /// ==========================================================
  /// Custom
  ///

  Future<dynamic> customPost(String endpoint,
      {String baseUrl, Map<String, dynamic> headers, body}) async {
    if (!await this.isConnected()) {
      throw new Exception('Verifique sua conexão!');
    }

    Dio client = _dio;

    if (baseUrl != null && baseUrl.isNotEmpty) {
      client = Dio(BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: 60000,
        receiveTimeout: 60000,
        sendTimeout: 60000,
      ));
    }

    Options options = Options();
    options.extra = {'ignoreInterceptor': true};
    options.headers = headers;

    dynamic response;

    try {
      response = await client.post(
        endpoint,
        data: body,
        options: options,
      );
    } catch (e) {
      print("Exception Request => (POST) => $endpoint");
      if (body != null) print('Exception Body => ${jsonEncode(body) ?? ''}');
      print('Exception Headers => ${e.request.headers}');
      print('Exception => ${e.response}');

      if (e is DioError) {
        var dioError = e;
        print('Exception Dio => ${dioError.message}');
        String message = dioError?.response?.data['message'];
        if (message != null) {
          throw new Exception(message);
        } else {
          throw new Exception(
              'Erro desconhecido! Entre em contato com um administrador do sistema.');
        }
      } else {
        throw new Exception(
            'Não foi possível concluir sua chamada! Tente novamente mais tarde.');
      }
    }

    print('Request Headers => ${response.request.headers}');
    print("Request (${response.request.method}) => ${response.request.uri}");
    if (response.request.data != null)
      print("${jsonEncode(response.request.data) ?? ''}");
    print("Response (${response.statusCode}) => ${jsonEncode(response.data)}");

    return response;
  }

  dynamic _generateResponse(Response response) {
    if (response == null) {
      print('404 - Response null');
      throw new Exception(
          'Não foi possível concluir sua chamada! Tente novamente mais tarde.');
    }

    final int statusCode = response.statusCode;

    print('Request Headers => ${response.request.headers}');
    print("Request (${response.request.method}) => ${response.request.uri}");
    if (response.request.data != null)
      print("${jsonEncode(response.request.data) ?? ''}");
    print("Response ($statusCode) => ${jsonEncode(response.data)}");

    final decoded = response.data;

    if (statusCode < 200 || statusCode > 204) {
      if (decoded != null && decoded["data"] != null) {
        throw new Exception(decoded["data"]);
      }
      throw new Exception(
          'Não foi possível concluir sua chamada! Tente novamente mais tarde.');
    }
    if (decoded == null) return null;
    if (decoded is List) {
      return decoded;
    } else if (decoded is Map) {
      if (decoded["data"] != null) {
        return decoded["data"];
      } else if (decoded.isNotEmpty) {
        return decoded;
      } else {
        return null;
      }
    }
    if (decoded is String && decoded.isEmpty)
      return null;
    else {
      return decoded;
    }
  }

  Future<Options> _getCustomConfig(
      Map<String, String> customHeader, bool ignoreInterceptor) async {
    Options options = Options();
    options.extra = {'ignoreInterceptor': ignoreInterceptor};
    options.headers = await this._getDefaultHeader(customHeader);
    return options;
  }

  Future<Map<String, dynamic>> _getDefaultHeader(
      Map<String, dynamic> customHeader) async {
    Map<String, dynamic> header = {};

    if (customHeader != null) {
      header.addAll(customHeader);
    }

    return header;
  }

  /// ==========================================================
  /// Extras

  Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }

  Future<dynamic> multipartFile(String url, File customFile,
      {Map headers, encoding, String fileName}) async {
    if (!await this.isConnected()) {
      throw new Exception('Verifique sua conexão e tente novamente!');
    }
    var postUri = Uri.parse(url);
    var request = new http.MultipartRequest('POST', postUri);
    request.headers['Content-Type'] = 'application/x-www-form-urlencoded';
    request.files.add(new http.MultipartFile.fromBytes(
        'image', await customFile.readAsBytes(),
        filename: fileName ?? 'image', contentType: MediaType('image', 'jpg')));

    return request.send().then((response) async {
      print("Request (MultipartFile): $url");
      print("Response Code: ${response.statusCode}");
      if (response.statusCode < 200 || response.statusCode > 204) {
        throw new Exception('Erro desconhecido!');
      } else {
        print("Uploaded!");
        var a = await response.stream.bytesToString();
        Map map = json.decode(a);
        return map['data'];
      }
    });
  }
}
