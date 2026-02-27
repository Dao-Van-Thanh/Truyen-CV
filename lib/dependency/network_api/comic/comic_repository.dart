import 'package:flutter_template/dependency/api/api_service.dart';
import 'package:flutter_template/dependency/api/extension/response_extension.dart';
import 'package:flutter_template/dependency/api/model/api_result.dart';
import 'package:flutter_template/dependency/network_api/base/base_data_response_model.dart';
import 'package:flutter_template/dependency/network_api/comic/category/list_category/list_comic_category_res.dart';
import 'package:flutter_template/dependency/network_api/comic/detail/comic_detail_res.dart';
import 'package:flutter_template/dependency/network_api/comic/list_comic/list_comic_res.dart';
import 'package:flutter_template/features/explore/enum/explore_comic_type.dart';

class ComicRepository {
  final ApiService apiService;

  ComicRepository(this.apiService);

  Future<ApiResult<BaseDataResponseModel<ListComicRes>>> getListByType(
    String typeSlug, {
    required int page, // init = 1
  }) async {
    // check nếu type Slug không thuộc ExploreComicType thì Slug đó thuộc về category, lúc đó sẽ gọi hàm getListByCategory thay vì getListByType
    final isTypeSlug =
        ExploreComicType.values.map((e) => e.slug).contains(typeSlug);

    if (!isTypeSlug) {
      return getListByCategory(typeSlug, page: page);
    }

    final response = await apiService.get(
      '/danh-sach/${typeSlug}?page=$page',
    );

    return response.parseDataComic(
      (json) => BaseDataResponseModel<ListComicRes>.fromJson(
        json,
        (data) => ListComicRes.fromJson(data as Map<String, dynamic>),
      ),
    );
  }

  Future<ApiResult<BaseDataResponseModel<ListComicCategoryRes>>>
      getListCategory() async {
    final response = await apiService.get(
      '/the-loai',
      shouldCache: true,
    );

    return response.parseDataComic(
      (json) => BaseDataResponseModel<ListComicCategoryRes>.fromJson(
        json,
        (data) => ListComicCategoryRes.fromJson(data as Map<String, dynamic>),
      ),
    );
  }

  Future<ApiResult<BaseDataResponseModel<ListComicRes>>> getListByCategory(
    String categorySlug, {
    required int page, // init = 1
  }) async {
    final response = await apiService.get(
      '/the-loai/$categorySlug?page=$page',
    );

    return response.parseDataComic(
      (json) => BaseDataResponseModel<ListComicRes>.fromJson(
        json,
        (data) => ListComicRes.fromJson(data as Map<String, dynamic>),
      ),
    );
  }

  Future<ApiResult<BaseDataResponseModel<ComicDetailRes>>> getComicDetail(
    String comicSlug,
  ) async {
    final response = await apiService.get(
      '/truyen-tranh/$comicSlug',
    );

    return response.parseDataComic(
      (json) => BaseDataResponseModel<ComicDetailRes>.fromJson(
        json,
        (data) => ComicDetailRes.fromJson(data as Map<String, dynamic>),
      ),
    );
  }

  Future<ApiResult<BaseDataResponseModel<ListComicRes>>> searchComic(
    String keyword, {
    required int page, // init = 1
  }) async {
    final response = await apiService.get(
      '/tim-kiem?keyword=$keyword&page=$page',
    );

    return response.parseDataComic(
      (json) => BaseDataResponseModel<ListComicRes>.fromJson(
        json,
        (data) => ListComicRes.fromJson(data as Map<String, dynamic>),
      ),
    );
  }
}
