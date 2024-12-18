import 'dart:convert';

class BaseResponse {
  String? transactionId;
  String? errorType;

  BaseResponse(this.transactionId, this.errorType);

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(json["transactionId"], json["errorType"]);
  }
}
