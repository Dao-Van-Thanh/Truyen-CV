import 'package:flutter_template/dependency/api/api_service.dart';
import 'package:flutter_template/dependency/api/extension/response_extension.dart';
import 'package:flutter_template/dependency/api/model/api_result.dart';
import 'package:flutter_template/dependency/network_api/base/base_data_response_model.dart';
import 'package:flutter_template/dependency/network_api/story/category/category_model.dart';
import 'package:flutter_template/dependency/network_api/story/filter/story_filter_request.dart';
import 'package:flutter_template/dependency/network_api/story/filter/story_filter_response.dart';

class StoryRepository {
  final ApiService apiService;

  StoryRepository(this.apiService);

  Future<ApiResult<BaseDataResponseModel<List<CategoryModel>>>>
      getListCategory() async {
    final response = await apiService.get(
      '/getListCategory',
      shouldCache: true,
    );

    return response.parseData(
      (json) => BaseDataResponseModel<List<CategoryModel>>.fromJson(
        json,
        (data) => (data as List<dynamic>)
            .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
    );
  }

  Future<ApiResult<StoryFilterResponse>> getStoryFilter({
    required StoryFilterRequest req,
  }) async {
    final res = await apiService.post(
      '/filter',
      queryParameters: req.toJson(),
    );

    return res.parseData(
      (json) => StoryFilterResponse.fromJson(json),
    );
  }
}
