class ResultSearchModel {
  String login;
  num id;
  String avatar_url;
  String html_url;

  ResultSearchModel(this.login, this.id, this.avatar_url);

  ResultSearchModel.map(Map<String, dynamic> json) {
    this.login = json["login"];
    this.id = json["id"];
    this.avatar_url = json["avatar_url"];
    this.html_url = json["html_url"];
  }
}
