class RedirectUrl {
  String successUrl;
  String failureUrl;

  RedirectUrl(this.successUrl, this.failureUrl);

  Map<String, dynamic> toJson() => {
    "successUrl": successUrl,
    "failureUrl": failureUrl
  };
}