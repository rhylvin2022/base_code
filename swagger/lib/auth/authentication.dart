// ignore_for_file: one_member_abstracts

part of swagger.api;

abstract class Authentication {
  /// Apply authentication settings to header and query params.
  void applyToParams(
      List<QueryParam> queryParams, Map<String, String> headerParams);
}
