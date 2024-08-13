
class VersionResponse {
  String? version;
  String? needUpdate;

  VersionResponse({
    this.version,
    this.needUpdate,
  });

  VersionResponse.fromJson(Map<String, dynamic> json){
    version = json['version'];
    needUpdate = json['needUpdate'];
  }

}
