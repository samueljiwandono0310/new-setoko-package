class APIs {
  APIs._constructor();

  static final APIs _instance = APIs._constructor();

  factory APIs() {
    return _instance;
  }

  /// Production Base url
  static const String productionBaseApi = "";

  /// Staging Base url
  static const String stagingBaseApi = "https://core.setoko-test.com";

  /// End points
  static const String products = "/v1/search";

  ///---------------------------------------------------------------------------------------------------------///
}
