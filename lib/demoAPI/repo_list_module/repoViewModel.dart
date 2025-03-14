
import 'package:drift/drift.dart';
import 'package:fff/demoAPI/repo_list_module/repoData.dart';
import 'package:fff/demoAPI/repo_list_module/repoService.dart';
import 'package:flutter/cupertino.dart';
import '../../common/NetworkService.dart';
import '../../local/database.dart';

class RepoViewModel extends ChangeNotifier{
  final ApiService _apiService = ApiService();
  final db = AppDatabase.getInstance();
  List<Repo> _list = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Repo> get list => _list;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchRepoList(String username) async{
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    bool isConnected = await NetworkService.hasInternetConnection();
    if (isConnected) {
      try{
        _list = await fetchFromApi(username);
        debugPrint("${_list.length}");
      }catch(e){
        _errorMessage = e.toString();
        debugPrint(_errorMessage);
      }
    }else{
      _list = await fetchLocalRepos();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> saveReposToLocal(List<RepoData> apiRepos) async {
    for (var repo in apiRepos) {
      final repoEntry = ReposCompanion(
        id: Value(repo.id!),
        name: Value(repo.name),
        description: Value(repo.description!),
        owner: Value(repo.owner!.login!),
        language: Value(repo.language),
        stars: Value(repo.stargazersCount!),
        url: Value(repo.gitUrl!),
      );
      await db.insertRepo(repoEntry);
    }
  }

  Future<List<Repo>> fetchFromApi(String username) async{
    final s = await _apiService.getRepoList(username);
    await saveReposToLocal(s);

    final res = s.map((repo) => Repo(
      id: repo.id!, name: repo.name,
      description: repo.description, owner: repo.owner!.login!,
      language: repo.language, stars: repo.stargazersCount!,url: repo.gitUrl!
    )).toList();

    return res;
  }

  Future<List<Repo>> fetchLocalRepos() async {
    return await db.getAllRepos();
  }

  // **1. Add a new repo manually**
  Future<void> addRepo(Repo repo) async {
    final newRepo = ReposCompanion(
      id: Value(repo.id),
      name: Value(repo.name),
      description: Value(repo.description),
      owner: Value(repo.owner),
      language: Value(repo.language),
      stars: Value(repo.stars),
      url: Value(repo.url),
    );

    await db.insertRepo(newRepo);
    _list.add(repo);
    notifyListeners();
  }

  // **2. Delete a repo**
  Future<void> deleteRepo(int repoId) async {
    await db.deleteRepoById(repoId);
    _list.removeWhere((repo) => repo.id == repoId);
    notifyListeners();
  }

  // **3. Update a repo**
  Future<void> updateRepo(Repo updatedRepo) async {
    final repoEntry = Repo(
      id: updatedRepo.id,
      name: updatedRepo.name,
      description: updatedRepo.description,
      owner: updatedRepo.owner,
      language: updatedRepo.language,
      stars: updatedRepo.stars,
      url: updatedRepo.url,
    );

    await db.updateRepo(repoEntry);

    int index = _list.indexWhere((repo) => repo.id == updatedRepo.id);
    if (index != -1) {
      _list[index] = updatedRepo;
      notifyListeners();
    }
  }
 }