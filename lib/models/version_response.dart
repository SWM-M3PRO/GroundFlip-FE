
class VersionResponse {
  String? version;
  DateTime? createdDate;

  VersionResponse({
    this.version,
    this.createdDate,
  });

  VersionResponse.fromJson(Map<String, dynamic> json){
    version = json['version'];
    createdDate = json['createdDate'] != null ? DateTime.parse(json['createdDate']) : null;
  }


}
