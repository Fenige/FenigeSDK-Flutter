import 'dart:convert';

import 'package:fenige_sdk/data/api.dart';
import 'package:fenige_sdk/data/base_response.dart';
import 'package:fenige_sdk/data/get_transaction_id_request.dart';

import 'dart:convert';

class FenigeApi extends Api {
  FenigeApi(super.hostUrl);

  Future<BaseResponse> getTransactionId(String apiKey, GetTransactionIdRequest request) async {
    // Log the request details
    print("Sending POST request to: ${hostUrl}/transactions/pre-initialization");
    print("Headers: {Api-Key: $apiKey, Content-Type: application/json}");
    print("Request Payload: ${jsonEncode(request.toJson())}");

    var response = await post(
      "transactions/pre-initialization",
      {"Api-Key": apiKey, "Content-Type": "application/json"},
      jsonEncode(request.toJson()),
    );

    // Log the response details
    print("Response: $response");

    var transactionIdResponse = BaseResponse.fromJson(response);
    return transactionIdResponse;
  }
}