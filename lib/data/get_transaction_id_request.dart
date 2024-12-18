import 'package:fenige_sdk/data/redirect_url.dart';
import 'package:fenige_sdk/data/sender.dart';

class GetTransactionIdRequest {
  String transactionId;
  String currency;
  int amount;
  String description;
  String formLanguage;
  RedirectUrl redirectUrl;
  Sender sender;
  String merchantUrl;
  String orderNumber;
  bool autoClear;
  bool isRecurring;

  GetTransactionIdRequest(
    this.transactionId,
    this.currency,
    this.amount,
    this.description,
    this.formLanguage,
    this.redirectUrl,
    this.sender,
    this.merchantUrl,
    this.orderNumber,
    this.autoClear,
    this.isRecurring,
  );

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = {
    "transactionId": transactionId,
    "currencyCode": currency,
    "amount": amount,
    "description": description,
    "formLanguage": formLanguage,
    "redirectUrl": redirectUrl.toJson(),
    "sender": sender.toJson(),
    "merchantUrl": merchantUrl,
    "orderNumber": orderNumber,
    "autoClear": autoClear,
    "typeOfAuthorization": isRecurring ? 'COF' : 'PURCHASE',
  };

  return data;
}
}