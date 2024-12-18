import 'dart:convert';

import 'package:http/http.dart' as http;

import 'base_response.dart';

abstract class Api {
  String hostUrl;

  Api(this.hostUrl);

  Future<Map<String, dynamic>> get(String endpoint) async {
    var response = await http.get(Uri.parse(hostUrl + endpoint));
    return _checkError(response);
  }

  Future<Map<String, dynamic>> post(String endpoint, Map<String, String> headers, Object request) async {
    var response = await http.post(Uri.parse(hostUrl + endpoint), headers: headers, body: request);
    return _checkError(response);
  }

  Future<Map<String, dynamic>> _checkError(http.Response response) async {
    if (response.statusCode == 200) {
      var baseResponse = BaseResponse.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
      if (baseResponse.errorType != null) {
        throw (baseResponse.errorType.toString());
      } else {
        return jsonDecode(response.body);
      }
    } else {
      throw (response.reasonPhrase.toString());
    }
  }
}
