import 'dart:convert';
import 'package:http/http.dart' as http;

mixin ApiHelper{
  Future<dynamic> getData(String url)async{
    try{
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        final res = jsonDecode(response.body);
        // if (res is Map<String, dynamic> && res.containsKey("items")) {
        //   return res["items"];
        // }
        return res;
      }else{
        return "error code comes";
      }
    }catch(e){
      return Exception("Server error");
    }
  }

  // Future<dynamic> apiCall()
}