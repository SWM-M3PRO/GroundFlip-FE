class CreateCommunityResponse {
  late int communityId;
  late int statusCode;

  CreateCommunityResponse(
      {required this.communityId, required this.statusCode});

  CreateCommunityResponse.fromJson(Map<String, dynamic> json, int statusCode) {
    this.communityId = json['data'];  // 'data' 필드에서 communityId 추출
    this.statusCode = statusCode;  // 응답의 statusCode 저장
  }
}
