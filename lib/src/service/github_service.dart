import 'package:poc_mobx/src/model/ResultGitHubDTO.dart';
import 'package:poc_mobx/src/service/base_service.dart';
import 'package:poc_mobx/src/utils/network_service/network_service.dart';

extension on String {
  normalize() {
    return this.replaceAll(" ", "+");
  }
}

class GitHubService extends BaseService {
  Future<List<ResultSearchModel>> searchListUsers({String searchText}) {
    return this
        .request(HttpMethod.GET, 'users?q=${searchText.normalize()}',
            cacheFirst: false)
        .then((response) {
      if (response == null) return null;
      final list = (response['items'] as List);
      return list.map((i) => ResultSearchModel.map(i)).toList();
    }).catchError((error) {
      throw (error);
    });
  }
}
