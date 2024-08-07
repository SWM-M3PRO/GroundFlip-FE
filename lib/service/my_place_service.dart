

import 'package:dio/dio.dart';

import '../models/my_place.dart';
import '../utils/dio_service.dart';
import '../utils/user_manager.dart';

class MyPlaceService{
  static final MyPlaceService _instance = MyPlaceService._internal();
  final Dio dio = DioService().getDio();
  MyPlaceService._internal();

  factory MyPlaceService(){
    return _instance;
  }

  Future<List<MyPlace>> getMyPlaceInfo() async{
    List<MyPlace> myPlaces;
    int? userId = UserManager().getUserId();
    var response = await dio.get('/myplace/$userId');
    myPlaces = MyPlace.listFromJson(response.data['data']);
    for(var e in myPlaces){
      print('1111 ${e.placePoint?.x},${e.placePoint?.y}, ${e.placeName}');
    }

    return myPlaces;
  }

}