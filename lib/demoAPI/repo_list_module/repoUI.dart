import 'package:fff/common/constants.dart';
import 'package:fff/demoAPI/repo_list_module/repoViewModel.dart';
import 'package:fff/local/database.dart';
import 'package:fff/login_module/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RepoListClass extends StatefulWidget {
  final AuthService authService;
  const RepoListClass({super.key, required this.authService});

  @override
  State<RepoListClass> createState() => _RepoListClassState();
}

class _RepoListClassState extends State<RepoListClass> {
  bool isFirstLoad = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isFirstLoad) {
      isFirstLoad = false;
      Future.microtask(() {
        if(!mounted) return;
        // Provider.of<RepoViewModel>(context, listen: false).fetchRepoList(ConstValues.gitName);
      });
    }
  }

  Future<void> _logout() async{
    await widget.authService.logout();
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("RepoList",style: TextStyle(color: Colors.black),),
        actions: [
          IconButton(onPressed: (){
            _showLogoutPopup();
          }, icon: Icon(Icons.person,color: Colors.black,)),
          IconButton(onPressed: (){
            Navigator.pushNamed(context, '/users');
          }, icon: Icon(Icons.contact_page_rounded,color: Colors.black,)),
          IconButton(onPressed: (){
            Navigator.pushNamed(context, '/chat');
          }, icon: Icon(Icons.chat,color: Colors.black,)),
          IconButton(onPressed: (){
            Navigator.pushNamed(context, '/loginPost');
          }, icon: Icon(Icons.login,color: Colors.black,)),
          IconButton(onPressed: (){
            Navigator.pushNamed(context, '/bottomsSheet');
          }, icon: Icon(Icons.punch_clock,color: Colors.black,)),

        ],backgroundColor: Colors.yellow,),
      body: Text("Hello"),

      // Consumer<RepoViewModel>(builder: (context,viewModel,child){
      //   if(viewModel.isLoading){
      //     return Center(child: const CircularProgressIndicator(color: Colors.black,));
      //   }
      //   if(viewModel.list.isEmpty){
      //     return Center(child: const Text("The List is empty",style: TextStyle(color: Colors.red)));
      //   }
      //   if(viewModel.errorMessage.isNotEmpty){
      //     return Center(child: Text(viewModel.errorMessage, style: const TextStyle(color: Colors.red)));
      //   }
      //   return  ListView.builder(itemBuilder: (BuildContext context,int index){
      //     return ListTile(title: Text(viewModel.list[index].name.toString()),
      //       subtitle: Text(viewModel.list[index].id.toString()),
      //       trailing: Row(mainAxisSize: MainAxisSize.min, children: [
      //         IconButton(onPressed: (){
      //           _showEditRepoPopup(viewModel.list[index],viewModel);
      //         }, icon: Icon(Icons.edit)),
      //         IconButton(onPressed: (){
      //           viewModel.deleteRepo(viewModel.list[index].id);
      //         }, icon: Icon(Icons.delete))
      //       ],),);
      //   },itemCount: viewModel.list.length,);
      // }),
      floatingActionButton: FloatingActionButton(onPressed: (){
        _showAddRepoPopup(RepoViewModel());
      },
      child: Icon(Icons.add),),
    );
  }

  void _showLogoutPopup(){
    showDialog(
      context: context,builder: (context){
        return AlertDialog(title: Text("Logout"),content: Text("Are you sure you want to logout?"),
        actions: [
          Center(child: ElevatedButton(onPressed: (){
            _logout();
          }, child: Text("Logout")),)
        ],);
    });
  }

  void _showAddRepoPopup(RepoViewModel viewModel){
    TextEditingController nameC = TextEditingController();
    TextEditingController descriptionC = TextEditingController();

    showDialog(context: context, builder: (context){
      return AlertDialog(title: Text("Add Repo"),content: Column(mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
              controller: nameC,
              decoration: InputDecoration(
                hintText: "Enter name",hintStyle: TextStyle(fontSize: 18,color: Colors.black),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 1,style: BorderStyle.solid),),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green, width: 2)),
              )),
          SizedBox(height: 10,),
          TextField(
              controller: descriptionC,
              decoration: InputDecoration(
                hintText: "Enter description",hintStyle: TextStyle(fontSize: 18,color: Colors.black),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 1,style: BorderStyle.solid),),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green, width: 2)),
              )),
        ],),
        actions: [
          ElevatedButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: Text("Cancel")),

          ElevatedButton(onPressed: (){
            final newRepo = Repo(
              id: DateTime.now().millisecondsSinceEpoch, // Temporary ID
              name: nameC.text, description: descriptionC.text, owner: "jemi-d", language: "Unknown",
              stars: 0, url: "https://github.com/jemi-d/${nameC.text}");
            viewModel.addRepo(newRepo);
            Navigator.of(context).pop();
          }, child: Text("Add"))
        ],
      );
    });
  }

  void _showEditRepoPopup(Repo data, RepoViewModel viewModel){
    TextEditingController nameC = TextEditingController(text: data.name);
    TextEditingController descriptionC = TextEditingController(text: data.description);

    showDialog(context: context, builder: (context){
      return AlertDialog(title: Text("Edit Repo"),content: Column(mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
            controller: nameC,
            decoration: InputDecoration(
              hintText: "Enter name",hintStyle: TextStyle(fontSize: 18,color: Colors.black),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 1,style: BorderStyle.solid),),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green, width: 2)),
            )),
        SizedBox(height: 10,),
        TextField(
            controller: descriptionC,
            decoration: InputDecoration(
              hintText: "Enter description",hintStyle: TextStyle(fontSize: 18,color: Colors.black),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 1,style: BorderStyle.solid),),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green, width: 2)),
            )),
      ],),
      actions: [
        ElevatedButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: Text("Cancel")),

        ElevatedButton(onPressed: (){
          Repo newUpdatedData  = Repo(id: data.id, name: nameC.text,description: descriptionC.text,
            language: data.language, owner: data.owner, stars: data.stars, url: "",);
          viewModel.updateRepo(newUpdatedData);
          Navigator.of(context).pop();
        }, child: Text("Edit"))
      ],
      );
    });
  }
}
