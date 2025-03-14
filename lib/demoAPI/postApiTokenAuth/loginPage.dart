import 'package:fff/common/ViewModelClass.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ApiService.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> getData() async{
    if(_formKey.currentState!.validate()){
      final authProvider = Provider.of<ViewModelClass>(context, listen: false);
      bool success = await authProvider.login(_nameController.text.trim(), _passwordController.text.trim());
     if(success){
       if(!mounted) return;
       Navigator.pushNamed(context, '/userProfile');
     }else{
       if(!mounted) return;
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Api Failed")));
     }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid Data")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"),centerTitle: true,backgroundColor: Colors.yellow,),
      body: Center(
        child: Container(padding: EdgeInsets.all(20),
          child: Form(
              key: _formKey,
              child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.yellow))),
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Please Enter your name';
                      }else{
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.yellow))),
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Please Enter your password';
                      }else{
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(onPressed: (){
                    print("onpress");
                    getData();
                  }, child: Text("Submit"))
                ],
          ))
        ),
      ),
    );
  }
}
