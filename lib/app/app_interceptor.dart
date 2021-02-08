import 'package:dio/dio.dart';

class AppInterceptor extends Interceptor {
  @override
  Future onRequest(RequestOptions options) async {
    if (options.extra['ignoreInterceptor'] == false) {
      Map<String, String> header = {"Content-Type": "application/json"};

    //póssiveis passagens de parametro pelo header.
      options.headers.addAll(header);
    }
    return super.onRequest(options);
  }
}