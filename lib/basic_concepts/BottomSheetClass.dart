import 'dart:async';
import 'dart:io';
import 'package:fff/common/ViewModelClass.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomSheetClass extends StatefulWidget {
  const BottomSheetClass({super.key});

  @override
  State<BottomSheetClass> createState() => _BottomSheetClassState();
}

class _BottomSheetClassState extends State<BottomSheetClass> {
  StreamSubscription? _subscription ;

  @override
  void initState() {
    // _subscription = getDataStream().listen((data){
    //   print("The stream data is $data");
    // });
    streamProcess();
    getDummyStreamApi();
    super.initState();
  }

  Stream<int> getDataStream() async*{
    for(var i =0;i<5;i++){
      await Future.delayed(Duration(seconds: 1));
      yield i;
    }
  }

  Stream<int> countUpToThree() async* {
    yield 1;
    yield 2;
    yield 3;
  }

  Stream<int> countNumbers() async* {
    yield 0;  // Emits 0 first
    yield* countUpToThree(); // Delegates control to countUpToThree
    yield 4;  // Emits 4 after countUpToThree finishes
  }

  void streamProcess() async {
    await for (var number in countNumbers()) {
      print("The stream yield* output $number");
    }
  }

  // Simulated API fetching users
  Stream<String> fetchUsers() async* {
    await Future.delayed(Duration(seconds: 1));
    yield "User 1";
    await Future.delayed(Duration(seconds: 1));
    yield "User 2";
  }

  // Simulated API fetching posts
  Stream<String> fetchPosts() async* {
    await Future.delayed(Duration(seconds: 1));
    yield "Post A";
    await Future.delayed(Duration(seconds: 1));
    yield "Post B";
  }

  Stream<String> fetchAllData() async* {
    yield "Fetching users...";
    yield* fetchUsers(); // Delegates to fetchUsers() stream

    yield "Fetching posts...";
    yield* fetchPosts(); // Delegates to fetchPosts() stream

    yield "All data loaded!";
  }

  void getDummyStreamApi() async{
    await for(var detail in fetchAllData()){
      print("the dummy api response $detail");
    };
  }


  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Basic UI"),centerTitle: true,backgroundColor: Colors.yellow,),
      body: Center(
        child: Container(padding: EdgeInsets.all(16),child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(Provider.of<ViewModelClass>(context).counter.toString(),style: TextStyle(fontSize: 18,color: Colors.black),),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: (){
              Provider.of<ViewModelClass>(context,listen: false).counterFun();
            }, child: Text("Count numbers")),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: (){
              _bottomSheet(context);
            }, child: Text("Show dialog")),
            SizedBox(height: 15,),
            _clockUI(context),

          ],
        ),)),
    );
  }

  void _bottomSheet(BuildContext context){
    if(!kIsWeb && (Platform.isAndroid || Platform.isIOS)){
      showModalBottomSheet(context: context, builder: (context) {
        return Container(height: 200,width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text("Bottom Sheet"),
              Text("This is Bottom Sheet"),
              ElevatedButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text("Close")),
              ElevatedButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text("Ok"))
            ],
          ),
        );
      },shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.only(
          bottomEnd: Radius.zero,bottomStart: Radius.zero,topStart: Radius.circular(10),topEnd: Radius.circular(10))
      ));
    }else{
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text("Alert dialog"),
          content: Column(
            children: [Text("This is Alert Dialog")],
          ),
          actions: [
            ElevatedButton(onPressed: (){}, child: Text("Close")),
            ElevatedButton(onPressed: (){}, child: Text("Ok")),
          ],
        );
      });
    }
  }

  Widget _clockUI(BuildContext context){
    return Stack(
      children: [
        // Gradient Background
        // Container(decoration: const BoxDecoration(
        //   gradient: LinearGradient(colors: [Colors.deepPurple, Colors.pinkAccent],
        //     begin: Alignment.topLeft, end: Alignment.bottomRight,),
        //   ),
        // ),
        Center(child: Consumer<ViewModelClass>(
            builder: (context, timerData, child) {
              return Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Circular Timer
                  SizedBox(height: 200, width: 200,
                    child: Stack(fit: StackFit.expand,
                      children: [
                        CircularProgressIndicator(value: timerData.progress, strokeWidth: 10,
                          backgroundColor: Colors.grey.shade200,
                          valueColor: const AlwaysStoppedAnimation(Colors.green),
                        ),
                        Center(child: Text("${timerData.seconds}s",
                            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.green,),
                        ),),],
                    ),),
                  const SizedBox(height: 30),
                  // Buttons Row
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Start Timer Button
                      ElevatedButton.icon(onPressed: timerData.isPause ? timerData.resumeTimer : timerData.startTimer,
                        icon: const Icon(Icons.play_arrow), label: Text(timerData.isPause ? "Resume" : "Start"),
                        style: ElevatedButton.styleFrom(foregroundColor: Colors.white, backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
                        ),
                      ),
                      const SizedBox(width: 20),

                      // Pause Timer Button
                      ElevatedButton.icon(onPressed: timerData.pauseTimer,
                        icon: const Icon(Icons.pause), label: const Text("Pause"),
                        style: ElevatedButton.styleFrom(foregroundColor: Colors.white, backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
                        ),
                      ),
                      const SizedBox(width: 20),

                      // Reset Timer Button
                      ElevatedButton.icon(onPressed: timerData.restartTimer,
                        icon: const Icon(Icons.refresh), label: const Text("Reset"),
                        style: ElevatedButton.styleFrom(foregroundColor: Colors.white, backgroundColor: Colors.redAccent,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
                        ),),],
                  ),],);
            },),
        ),
      ],
    );
  }
}
