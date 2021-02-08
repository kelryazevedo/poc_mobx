import 'package:mobx/mobx.dart';
import 'package:poc_mobx/src/model/ResultGitHubDTO.dart';
import 'package:poc_mobx/src/service/github_service.dart';
import 'package:poc_mobx/src/service/status_data/service_status_data.dart';
import 'package:poc_mobx/src/utils/global.dart';

part 'home_controller.g.dart';

class HomeController = _HomeController with _$HomeController;

abstract class _HomeController with Store {
  GitHubService service = GitHubService();
  final listUsers = ServiceStatusData<List<ResultSearchModel>>();

  searchList(String search) {
    listUsers.setPending();
    service.searchListUsers(searchText: search).then((value) {
      listUsers.setDone(value);
    }).catchError((e) {
      mobkAlert.showAlert(message: e.message);
      listUsers.setError(e);
    });
  }
}
