import 'dart:convert';
import 'dart:io';
import 'package:poc_mobx/src/model/CacheDTO.dart';
import 'package:poc_mobx/src/utils/network_service/network_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseService {
  final _frwkNetwork = NetworkService.instance;

  Future<dynamic> request(
      HttpMethod method,
      String endpoint, {
        Map headers,
        body,
        bool cacheFirst = false,
        bool ignoreInterceptor = false,
      }) async {
    if (cacheFirst) {
      dynamic response = await this._getCache(endpoint);
      if (response != null) {
        this._doRequest(
          method,
          endpoint,
          headers: headers,
          body: body,
          saveCache: cacheFirst,
          ignoreInterceptor: ignoreInterceptor,
        );
        return response;
      } else {
        return this._doRequest(
          method,
          endpoint,
          headers: headers,
          body: body,
          saveCache: cacheFirst,
          ignoreInterceptor: ignoreInterceptor,
        );
      }
    }
    return this._doRequest(
      method,
      endpoint,
      headers: headers,
      body: body,
      saveCache: cacheFirst,
      ignoreInterceptor: ignoreInterceptor,
    );
  }

  Future<dynamic> _doRequest(HttpMethod method, String endpoint,
      {Map<String, dynamic> headers,
        body,
        bool saveCache,
        bool ignoreInterceptor}) {
    return _frwkNetwork
        .request(method, endpoint,
        headers: headers, body: body, ignoreInterceptor: ignoreInterceptor)
        .then((response) async {
      if (saveCache) this._saveCache(endpoint, response);
      return response;
    }).catchError((error) {
      throw (error);
    });
  }

  Future<dynamic> customPost(
      String endpoint, {
        String baseUrl,
        Map<String, dynamic> headers,
        body,
      }) {
    return _frwkNetwork
        .customPost(
      endpoint,
      headers: headers,
      baseUrl: baseUrl,
      body: body,
    )
        .then((response) async {
      return response;
    }).catchError((error) {
      throw (error);
    });
  }

  Future<dynamic> _getCache(String endpoint) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var str = prefs.getString(endpoint);
    if (str == null) return null;
    var cacheData = CacheDTO.map(json.decode(str));
    if (cacheData != null && cacheData.isCacheValid) {
      var decodedData = json.decode(cacheData.data);
      return decodedData;
    } else
      return null;
  }

  _saveCache(String key, dynamic map) async {
    var encodedData = json.encode(map);
    var cacheData = CacheDTO(data: encodedData);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(cacheData.toMap()));
  }

  Future<dynamic> multipartFile(String url, File customFile,
      {Map headers, encoding, String fileName}) async {
    return _frwkNetwork.multipartFile(url, customFile, fileName: fileName);
  }
}
