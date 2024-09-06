import 'package:dio/dio.dart';

import '../models/search_group.dart';
import '../utils/dio_service.dart';

class SearchGroupService {
  static final SearchGroupService _instance = SearchGroupService._internal();

  SearchGroupService._internal();

  factory SearchGroupService() {
    return _instance;
  }

  final Dio dio = DioService().getDio();

  Future<List<SearchGroupResult>> getSearchGroups({
    required String searchKeyword,
  }) async {
    print('1111 ${searchKeyword}');
    var response = await dio.get(
      '/communities',
      queryParameters: {'searchKeyword': searchKeyword},
    );
    print('2222 ${searchKeyword},${SearchGroupResult.listFromJson(response.data['data'])}');
    return SearchGroupResult.listFromJson(response.data['data']);
  }
}
