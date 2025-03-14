import 'package:flutter/material.dart';
import 'dart:async';


/// Timer & Future delay & setState()
class TimerDelayClass extends StatefulWidget {
  const TimerDelayClass({super.key});

  @override
  State<TimerDelayClass> createState() => _TimerDelayClassState();
}

class _TimerDelayClassState extends State<TimerDelayClass> {
  TextEditingController controller = TextEditingController();
  List<String> nameList = [];

  @override
  void initState() {
    nameList = ["jemi","jesi","jeni"];
    super.initState();
  }

  void doThis() {
    Future.delayed(Duration(seconds: 2),(){
      debugPrint("do this delayed print");
    });
  }

  void delayFun(){
    Future.delayed(Duration(milliseconds: 200),(){
      debugPrint("before do this ");
      doThis();
    });
  }

  void timerFun(){
    Timer.periodic(Duration(seconds: 1), (timer){
      debugPrint("${timer.tick}");
      if(timer.tick == 7){
        timer.cancel();
      }
    });
  }

  void addLists(){
    setState(() {
      nameList.add("${nameList.length + 1}");
    });
  }

  @override
  Widget build(BuildContext context) {
    // var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(flex: 1,
              child: Container(width: width,height: 200,color: Colors.black,padding: EdgeInsets.all(16),
                child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextField(
                      controller: controller,
                      style: TextStyle(fontSize: 20,color: Colors.blue),
                    ),
                    TextField(
                      controller: controller,
                      style: TextStyle(fontSize: 20,color: Colors.blue),
                    ),
                    ElevatedButton(onPressed: (){
                      // timerFun();
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => AnimationOne()));
                      addLists();
                    }, child: Text("Add")),
                  ],
                ),
              ),
            ),
            Expanded(flex: 4,
              child: ListView.builder(itemCount: nameList.length,itemBuilder: (context,index){
                return ListTile(title: Text(nameList[index]),);
              }),
            )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(onPressed: (){},child: Icon(Icons.add),),
    );
  }
}




