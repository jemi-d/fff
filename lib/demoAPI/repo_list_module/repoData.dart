
class ReposData {
  List<RepoData>? repos;
  ReposData({this.repos});

  ReposData.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      repos = <RepoData>[];
      json['items'].forEach((v) {
        repos!.add(RepoData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (repos != null) {
      data['items'] = repos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RepoData {
  int? id;
  String name = "";
  String? fullName;
  bool? private;
  Owner? owner;
  String? description;
  String? gitUrl;
  int? stargazersCount;
  int? watchersCount;
  String? language;

  RepoData(
      {required this.id,
        required this.name,
        required this.fullName,
        required this.private,
        required this.owner,
        required this.description,
        required this.gitUrl,
        required this.stargazersCount,
        required this.watchersCount,
        required this.language,});

  RepoData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    fullName = json['full_name'];
    private = json['private'];
    owner = (json['owner'] != null ? Owner.fromJson(json['owner']) : null)!;
    description = json['description'] ?? 'No description';
    gitUrl = json['git_url'];
    stargazersCount = json['stargazers_count'];
    watchersCount = json['watchers_count'];
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['full_name'] = fullName;
    data['private'] = private;
    data['owner'] = owner?.toJson();
    data['description'] = description;
    data['git_url'] = gitUrl;
    data['stargazers_count'] = stargazersCount;
    data['watchers_count'] = watchersCount;
    data['language'] = language;
    return data;
  }
}

class Owner {
  String? login;
  int? id;
  String? avatarUrl;

  Owner(
      {required this.login,
        required this.id,
        required this.avatarUrl,
      });

  Owner.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    id = json['id'];
    avatarUrl = json['avatar_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['login'] = login;
    data['id'] = id;
    data['avatar_url'] = avatarUrl;
    return data;
  }
}
