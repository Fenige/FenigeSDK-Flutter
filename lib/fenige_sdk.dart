library fenige_sdk;

import 'package:fenige_sdk/data/redirect_url.dart';
import 'package:fenige_sdk/data/enviroment.dart';
import 'package:fenige_sdk/webview_screen.dart';
import 'package:flutter/cupertino.dart';
import 'data/sender.dart';

class FenigeSDK {
  static Widget createPayment(
      FenigeEnvironment environment,
      String apiKey,
      String transactionId,
      int amount,
      String currency,
      String paymentDescription,
      String merchantUrl,
      String orderNumber,
      String formLanguage,
      RedirectUrl redirectUrl,
      Sender sender,
      bool autoClear,
      bool isRecurring) {
        
    return WebViewScreen(
      environment,
      apiKey,
      transactionId,
      amount,
      currency,
      paymentDescription,
      merchantUrl,
      orderNumber,
      formLanguage,
      redirectUrl,
      sender,
      autoClear,
      isRecurring,
    );
  }
}