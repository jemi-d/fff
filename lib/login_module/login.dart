import 'package:fff/demoAPI/repo_list_module/repoUI.dart';
import 'package:fff/login_module/auth_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final AuthService authService;
  const LoginPage({super.key, required this.authService});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> _login() async{
    String userEmail = emailController.text.trim();
    String password = passwordController.text.trim();
    bool isSuccess = await widget.authService.login(userEmail, password);
    if (!mounted) return;
    if(isSuccess){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RepoListClass(authService: widget.authService,)));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid data")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(color: Colors.yellow,padding: EdgeInsets.all(20),
          child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Enter email",hintStyle: TextStyle(fontSize: 18,color: Colors.black),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 1,style: BorderStyle.solid),),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green, width: 2)),
              )),
            SizedBox(height: 20,),
            TextField(
              controller: passwordController,
                decoration: InputDecoration(
                  hintText: "Enter password",hintStyle: TextStyle(fontSize: 18,color: Colors.black),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 1,style: BorderStyle.solid),),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green, width: 2)),
                )),
            SizedBox(height: 40,),
            ElevatedButton(onPressed: (){
              _login();
            }, child: Text("Submit",style: TextStyle(color: Colors.black),))
          ],),
        ),
      ),
    );
  }
}
