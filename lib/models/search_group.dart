class SearchGroupResult {
  String name;
  String backgroundImageUrl;
  String communityColor;
  int id;

  SearchGroupResult(
      {required this.name,
      required this.backgroundImageUrl,
      required this.communityColor,
      required this.id});

  factory SearchGroupResult.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'name': var name,
        'backgroundImageUrl': var backgroundImageUrl,
        'communityColor': var communityColor,
        'id': var id
      } =>
        SearchGroupResult(
            name: name,
            backgroundImageUrl: backgroundImageUrl,
            communityColor: communityColor,
            id: id,
        ),
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
