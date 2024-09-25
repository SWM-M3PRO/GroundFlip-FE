class SearchCommunityResponse {
  String name;
  String backgroundImageUrl;
  String communityColor;
  int id;

  SearchCommunityResponse(
      {required this.name,
      required this.backgroundImageUrl,
      required this.communityColor,
      required this.id,});

  factory SearchCommunityResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'name': var name,
        'backgroundImageUrl': var backgroundImageUrl,
        'communityColor': var communityColor,
        'id': var id
      } =>
        SearchCommunityResponse(
            name: name,
            backgroundImageUrl: backgroundImageUrl,
            communityColor: communityColor,
            id: id,
        ),
      _ => throw const FormatException('Failed to load group')
    };
  }

  static List<SearchCommunityResponse> listFromJson(List<dynamic> jsonList) {
    return [
      for (var element in jsonList)
        if (element != null) SearchCommunityResponse.fromJson(element),
    ];
  }
}
