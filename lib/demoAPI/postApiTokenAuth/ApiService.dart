import 'dart:convert';
import 'package:fff/common/ViewModelClass.dart';
import 'package:fff/demoAPI/postApiTokenAuth/UserDetails.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../../common/constants.dart';

class PostService{

  final urlAuth = Uri.parse("${ConstValues.urlDummy}/auth/login");

  Future<UserDetails> callAPI(String username, String password) async {
    final response = await http.post(urlAuth,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
        }));

    if(response.statusCode == 200){
      final result = jsonDecode(response.body);
      UserDetails res = UserDetails.fromJson(result);
      print('the data ${res.email}');
      return res;
    }else{
      throw Exception('error');
    }
  }

  // ------------------------------------------ Generic API call method ------------------------------------------
  static final storage = FlutterSecureStorage();

  // Generic API Request Function
  static Future<http.Response> sendRequest({
    required String endpoint, // API endpoint (e.g., /auth/login)
    required String method,   // HTTP method (GET, POST, PUT, DELETE)
    Map<String, String>? headers, // Request headers
    dynamic body,             // Request body (for POST/PUT)
  }) async {
    // Fetch the stored access token
    String? accessToken = await storage.read(key: "access_token");

    // Set default headers
    headers = headers ?? {};
    headers["Authorization"] = "Bearer $accessToken";
    headers["Content-Type"] = "application/json";

    Uri url = Uri.parse("${ConstValues.urlDummy}$endpoint");

    // Perform API request
    http.Response response;
    switch (method) {
      case "POST":
        response = await http.post(url, headers: headers, body: jsonEncode(body));
        break;
      case "GET":
        response = await http.get(url, headers: headers);
        break;
      case "PUT":
        response = await http.put(url, headers: headers, body: jsonEncode(body));
        break;
      case "DELETE":
        response = await http.delete(url, headers: headers);
        break;
      default:
        throw Exception("Invalid HTTP method");
    }

    // Handle Unauthorized Access (Token Expired)
    if (response.statusCode == 401) {
      print("Access token expired! Trying to refresh...");
      await ViewModelClass().refreshAccessToken(); // Refresh the token

      // Retry request with new token
      accessToken = await storage.read(key: "access_token");
      headers["Authorization"] = "Bearer $accessToken";

      switch (method) {
        case "POST":
          response = await http.post(url, headers: headers, body: jsonEncode(body));
          break;
        case "GET":
          response = await http.get(url, headers: headers);
          break;
        case "PUT":
          response = await http.put(url, headers: headers, body: jsonEncode(body));
          break;
        case "DELETE":
          response = await http.delete(url, headers: headers);
          break;
      }
    }

    return response;
  }

  // Future<dynamic> getMyProfile(String accessToken, String refreshT)async{
  //   final response = await http.get(urlProfile,
  //       headers: {"Authorization" : "Bearer $accessToken"});
  //
  //   if(response.statusCode == 200){
  //     final result = jsonDecode(response.body);
  //     return result;
  //   }else if(response.statusCode == 401){
  //     final res = await refreshToken(refreshT);
  //     return res;
  //   }
  //   else{
  //     throw Exception('error');
  //   }
  // }
  //
  // Future<dynamic> refreshToken(String refreshToken)async{
  //
  //   final response = await http.post(Uri.parse("${ConstValues.urlAuth}/refresh"),
  //     headers: {"Content-Type": "application/json"},
  //     body: jsonEncode({"refreshToken": refreshToken}),
  //   );
  //
  //   if(response.statusCode == 200){
  //     final result = jsonDecode(response.body);
  //     return result;
  //   }
  //   else{
  //     throw Exception('error');
  //   }
  // }
}