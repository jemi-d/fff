import 'package:fff/demoAPI/repo_list_module/repoData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService{
  final String baseUrl = "https://api.github.com";
  Future<List<RepoData>> getRepoList(String username) async{
    final response = await http.get(Uri.parse("$baseUrl/users/$username/repos"));
    if(response.statusCode == 200){
      final List<dynamic> list = jsonDecode(response.body);
      return list.map((json) => RepoData.fromJson(json)).toList();
    }else{
        throw Exception("response get failed");
    }
  }

}