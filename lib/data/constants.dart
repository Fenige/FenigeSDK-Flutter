import 'package:flutter/foundation.dart';
import 'package:fenige_sdk/data/enviroment.dart';

class Constants {
  static String getTransactionUrl(FenigeEnvironment environment) {
    switch (environment) {
      case FenigeEnvironment.production:
        return "https://paytool.fenige.pl/";
      case FenigeEnvironment.development:
        return "https://paytool-dev.fenige.pl/";
      default:
        return "https://paytool-dev.fenige.pl/"; // Default to development
    }
  }

  static String getApiUrl(FenigeEnvironment environment) {
    switch (environment) {
      case FenigeEnvironment.production:
        return "https://paytool-api.fenige.pl/";
      case FenigeEnvironment.development:
        return "https://paytool-api-dev.fenige.pl/";
      default:
        return "https://paytool-api-dev.fenige.pl/"; // Default to development
    }
  }
}