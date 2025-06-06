part of swagger.api;

class OAuth implements Authentication {
  OAuth({this.accessToken}) {}

  String? accessToken;

  @override
  void applyToParams(
      List<QueryParam> queryParams, Map<String, String> headerParams) {
    if (accessToken != null) {
      // headerParams["Authorization"] = "Bearer " + accessToken;
    }
  }

  void setAccessToken(String accessToken) {
    this.accessToken = accessToken;
  }
}
