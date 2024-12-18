import 'dart:io';

import 'package:fenige_sdk/data/constants.dart';
import 'package:fenige_sdk/data/enviroment.dart';
import 'package:fenige_sdk/data/fenige_api.dart';
import 'package:fenige_sdk/data/get_transaction_id_request.dart';
import 'package:fenige_sdk/data/redirect_url.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'data/sender.dart';

class WebViewScreen extends StatefulWidget {
  final FenigeEnvironment environment;
  final String apiKey;
  final String transactionId;
  final int amount;
  final String currency;
  final String paymentDescription;
  final String merchantUrl;
  final String orderNumber;
  final String formLanguage;
  final RedirectUrl redirectUrl;
  final Sender sender;
  final bool autoClear;
  final bool isRecurring;

  const WebViewScreen(
    this.environment,
    this.apiKey,
    this.transactionId,
    this.amount,
    this.currency,
    this.paymentDescription,
    this.merchantUrl,
    this.orderNumber,
    this.formLanguage,
    this.redirectUrl,
    this.sender,
    this.autoClear,
    this.isRecurring, {
    super.key,
  });

  @override
  State createState() {
    return _WebViewViewState(
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

class _WebViewViewState extends State<WebViewScreen> {
  final FenigeEnvironment environment;
  final String apiKey;
  final String transactionId;
  final int amount;
  final String currency;
  final String paymentDescription;
  final String merchantUrl;
  final String orderNumber;
  final String formLanguage;
  final RedirectUrl redirectUrl;
  final Sender sender;
  final bool autoClear;
  final bool isRecurring;

  String _resultTransactionId = "";

  late final String transactionUrl;
  late final String apiUrl;

  _WebViewViewState(
    this.environment,
    this.apiKey,
    this.transactionId,
    this.amount,
    this.currency,
    this.paymentDescription,
    this.merchantUrl,
    this.orderNumber,
    this.formLanguage,
    this.redirectUrl,
    this.sender,
    this.autoClear,
    this.isRecurring,
  ) {
    transactionUrl = Constants.getTransactionUrl(environment);
    apiUrl = Constants.getApiUrl(environment);
  }

  @override
  void initState() {
    super.initState();
    getTransactionId();
  }

  Future<void> getTransactionId() async {
    var api = FenigeApi(apiUrl);
    var response = await api.getTransactionId(
      apiKey,
      GetTransactionIdRequest(
        transactionId,
        currency,
        amount,
        paymentDescription,
        formLanguage,
        redirectUrl,
        sender,
        merchantUrl,
        orderNumber,
        autoClear,
        isRecurring,
      ),
    );

    if (response.transactionId != null) {
      _resultTransactionId = response.transactionId!;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            if (url.contains(redirectUrl.successUrl) || url.contains(redirectUrl.failureUrl)) {
              Navigator.pop(context, _resultTransactionId);
            }
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      );

      if(Platform.isIOS) {
        controller.enableZoom(false);
      }

      controller.loadRequest(Uri.parse(transactionUrl + _resultTransactionId));
    
    return WebViewWidget(controller: controller);
  }
}