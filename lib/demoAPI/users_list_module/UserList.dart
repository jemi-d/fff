import 'package:fff/demoAPI/users_list_module/UserViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserListClass extends StatefulWidget {
  const UserListClass({super.key});

  @override
  State<UserListClass> createState() => _UserListClassState();
}

class _UserListClassState extends State<UserListClass> {
  bool isFirst = true;

  @override
  void didChangeDependencies() {
    if(isFirst){
      isFirst = false;
      Future.microtask((){
        if(!mounted) return;
        Provider.of<UserViewModel>(context,listen: false).getData();
      });
    }
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Users List",style: TextStyle(color: Colors.black)),backgroundColor: Colors.yellow,
      centerTitle: true,leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),),
      body: Consumer<UserViewModel>(builder: (context,data,child){
        if(data.isLoading){
          return Center(child: CircularProgressIndicator(color: Colors.black,),);
        }
        if(data.errorMessage.isNotEmpty){
          return Center(child: Text(data.errorMessage,style: TextStyle(color: Colors.red),),);
        }
        if(data.userData.isEmpty){
          return Center(child: Text("No data found", style: TextStyle(color: Colors.red),),);
        }
        return ListView.builder(itemCount: data.userData.length,
            itemBuilder: (BuildContext context, int index){
          return ListTile(title: Text(data.userData[index].firstName.toString()),);
        });
      }),
    );
  }
}
