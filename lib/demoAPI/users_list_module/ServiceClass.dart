import 'package:fff/common/constants.dart';
import 'package:fff/demoAPI/ApiHelper.dart';
import 'package:fff/demoAPI/users_list_module/UserDataClass.dart';
import '../repo_list_module/repoData.dart';

class ServiceClass with ApiHelper{

  Future<UsersData> getUser()async {
    final response = await getData("${ConstValues.urlDummy}/users");
    return UsersData.fromJson(response);
  }

  // Future<ReposData> getRepoList(String username) async{
  //   final response = await getData("${ConstValues.urlGetRepos}/users/$username/repos");
  //   // final res = response.map((json) => RepoData.fromJson(json)).toList();
  //   return ReposData.fromJson(response.map((json) => RepoData.fromJson(json)).toList());
  // }

}