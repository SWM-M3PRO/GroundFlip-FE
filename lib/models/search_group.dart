class SearchGroupResult {
  String name;

  SearchGroupResult({required this.name});

  factory SearchGroupResult.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'name': var name} => SearchGroupResult(name: name),
      _ => throw const FormatException('Failed to load group')
    };
  }

  static List<SearchGroupResult> listFromJson(List<dynamic> jsonList) {
    return [for (var element in jsonList) SearchGroupResult.fromJson(element)];
  }
}
