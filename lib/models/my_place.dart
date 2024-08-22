import 'dart:math';

class MyPlace{
  String? placeName;
  Point? placePoint;

  MyPlace({
    this.placeName,
    this.placePoint,
});

  MyPlace.fromJson(Map<String,dynamic>json){
    var coordinates = json['placePoint']['coordinates'];
    placeName = json['placeName'];
    placePoint = Point(coordinates[1], coordinates[0]);
  }

  static List<MyPlace> listFromJson(List<dynamic> jsonList){
    return [for (var element in jsonList) MyPlace.fromJson(element)];
  }
}