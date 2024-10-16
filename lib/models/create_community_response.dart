class CreateCommunityResponse {
  late int communityId;
  late int statusCode;

  CreateCommunityResponse({
    required this.communityId,
    required this.statusCode,
  });

  CreateCommunityResponse.fromJson(Map<String, dynamic> json, this.statusCode) {
    communityId = json['data'];
  }
}
