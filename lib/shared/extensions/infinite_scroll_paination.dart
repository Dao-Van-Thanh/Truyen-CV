import 'package:truyen_cv/constants/constants.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

extension PagingStateExtension<PageKeyType, ItemType>
    on PagingState<PageKeyType, ItemType> {
  bool isLastPage({int pageSize = CommonConstants.pageSize}) {
    final lastPage = pages?.lastOrNull;
    if (lastPage == null) return false;
    return lastPage.length < pageSize;
  }
}
