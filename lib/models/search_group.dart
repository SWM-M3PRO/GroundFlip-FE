class SearchGroupResult {
  String name;
  String backgroundImageUrl;
  String communityColor;

  SearchGroupResult(
      {required this.name,
      required this.backgroundImageUrl,
      required this.communityColor});

  factory SearchGroupResult.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'name': var name,
        'backgroundImageUrl': var backgroundImageUrl,
        'communityColor': var communityColor
      } =>
        SearchGroupResult(
            name: name,
            backgroundImageUrl: backgroundImageUrl,
            communityColor: communityColor),
      _ => throw const FormatException('Failed to load group')
    };
  }

  static List<SearchGroupResult> listFromJson(List<dynamic> jsonList) {
    return [
      for (var element in jsonList)
        if (element != null) SearchGroupResult.fromJson(element)
    ];
  }
}
