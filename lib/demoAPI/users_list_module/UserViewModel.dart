
import 'package:fff/demoAPI/users_list_module/UserDataClass.dart';
import 'package:fff/demoAPI/users_list_module/ServiceClass.dart';
import 'package:flutter/cupertino.dart';
import '../../common/NetworkService.dart';

class UserViewModel extends ChangeNotifier{

  final ServiceClass _service = ServiceClass();
  late List<Users> _userData = [];
  bool _isLoading = false;
  String _errorMessage = "";

  List<Users> get userData  => _userData;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> getData() async{
    _isLoading = true;
    _errorMessage = "";
    notifyListeners();

    bool isConnected = await NetworkService.hasInternetConnection();
    if (isConnected) {
      try{
        final res = await _service.getUser();
        _userData = res.users!;
      }catch(e){
        _errorMessage = e.toString();
        debugPrint(_errorMessage);
      }
    }else{
      _errorMessage = "Please check your internet connection";
      debugPrint(_errorMessage);
    }

    _isLoading = false;
    notifyListeners();
  }
}