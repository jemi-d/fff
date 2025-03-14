import 'package:fff/common/ViewModelClass.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Userprofile extends StatefulWidget {
  const Userprofile({super.key});

  @override
  State<Userprofile> createState() => _UserprofileState();
}

class _UserprofileState extends State<Userprofile> {
  @override
  Widget build(BuildContext context) {
    final response = Provider.of<ViewModelClass>(context,listen: false);

    return Scaffold(
      appBar: AppBar(title: Text("User Profile"),centerTitle: true,backgroundColor: Colors.yellow,),
      body: Center(child: Container(padding: EdgeInsets.all(16),color: Colors.white,child:Column(
        crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(response.user!.id.toString(),style: TextStyle(fontSize: 20,color: Colors.black),),
          Text(response.user!.email.toString(),style: TextStyle(fontSize: 20,color: Colors.black),),
          Text(response.user!.username.toString(),style: TextStyle(fontSize: 20,color: Colors.black),),
          Text(response.user!.gender.toString(),style: TextStyle(fontSize: 20,color: Colors.black),),
        ],
      ),),),
    );
  }
}
