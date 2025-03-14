import 'dart:async';
import 'dart:convert';
import 'package:fff/demoAPI/postApiTokenAuth/UserDetails.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../demoAPI/postApiTokenAuth/ApiService.dart';

class ViewModelClass extends ChangeNotifier{
  // ------------------------- for counter -------------------------------
  int _counter = 0;
  int get counter => _counter;

  void counterFun(){
    _counter++;
    notifyListeners();
  }

  // ------------------------- for Timer clock ----------------------------
  int _seconds = 60;
  Timer? _timer;
  double _progress = 1.0;
  bool _isPause = false;

  int get seconds => _seconds;
  bool get isRunning => _timer != null && _timer!.isActive;
  double get progress => _progress;
  bool get isPause => _isPause;

  void startTimer(){
    if(_timer != null && _timer!.isActive) return;
    _timer = Timer.periodic(Duration(seconds: 1), (timer){
      if(_seconds > 0){
        _seconds--;
        _progress = _seconds/60;
        notifyListeners();
      }else{
        timer.cancel();
        _timer = null;
        notifyListeners();
      }
    });
  }

  void pauseTimer(){
    if(_timer != null && _timer!.isActive){
      _timer?.cancel();
      _isPause = true;
      notifyListeners();
    }
  }

  void resumeTimer(){
    if(_isPause){
      startTimer();
    }
  }

  void restartTimer(){
    _timer?.cancel();
    _seconds = 60;
    _progress = 1.0;
    _isPause = false;
    notifyListeners();
  }

  // ------------------------ for User Authentication --------------------------
  final storage = FlutterSecureStorage();
  final _apiService = PostService();

  String? _accessToken;
  String? _refreshToken;
  UserDetails? _user;

  String? get accessToken => _accessToken;
  UserDetails? get user => _user;

  // User Login
  Future<bool> login(String username, String password) async{
    UserDetails userDetails = await _apiService.callAPI(username, password);

    if(userDetails != null){
      await storage.write(key: "access_token", value: userDetails.accessToken);
      await storage.write(key: "refresh_token", value: userDetails.refreshToken);
      _refreshToken = userDetails.refreshToken;
      _accessToken = userDetails.accessToken;
      await fetchUserProfile();
      notifyListeners();
      return true;
    }else{
      return false;
    }
  }

  // Fetch User Profile
  Future<void> fetchUserProfile() async {
    final response = await PostService.sendRequest(
      endpoint: "/auth/me",
      method: "GET",
    );

    if (response.statusCode == 200) {
      _user = UserDetails.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      await refreshAccessToken();
    }
    notifyListeners();
  }

  // Refresh Token
  Future<void> refreshAccessToken() async {
    _refreshToken = await storage.read(key: "refresh_token");
    if (_refreshToken == null) {
      logout();
      return;
    }

    final response = await PostService.sendRequest(
      endpoint: "/auth/refresh",
      method: "POST",
      body: {"refreshToken": _refreshToken},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _accessToken = data["accessToken"];
      await storage.write(key: "access_token", value: _accessToken);
      notifyListeners();
    } else {
      logout();
    }
  }

  // Logout and Clear Storage
  Future<void> logout() async {
    _accessToken = null;
    _refreshToken = null;
    _user = null;
    await storage.deleteAll();
    notifyListeners();
  }

  // // Fetch user profile data
  // Future<void> fetchUserProfile() async {
  //
  //   if (_accessToken == null) return;
  //   final response = await _apiService.getMyProfile(_accessToken!,_refreshToken!);
  //   if (response != null) {
  //     final d = UserDetails.fromJson(response);
  //     if(d.email == null){
  //
  //     }
  //     _user = d;
  //   }
  //   notifyListeners();
  // }
  //
  // // Refresh Token API Call
  // Future<void> refreshAccessToken() async {
  //   _refreshToken = await storage.read(key: "refresh_token");
  //
  //   if (_refreshToken == null) {
  //     logout();
  //     return;
  //   }
  //   final response = await _apiService.refreshToken(_refreshToken!);
  //
  //   if (response != null) {
  //     _accessToken = response['access_token'];
  //     await storage.write(key: "access_token", value: _accessToken);
  //     notifyListeners();
  //   } else {
  //     logout(); // Refresh failed, log out user
  //   }
  // }

}
