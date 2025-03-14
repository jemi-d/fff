import 'package:flutter/material.dart';


class AnimationClass extends StatefulWidget {
  const AnimationClass({super.key});

  @override
  State<AnimationClass> createState() => _AnimationClassState();
}

class _AnimationClassState extends State<AnimationClass> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween<double>(begin: 0.5,end: 1.5).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut)
    );
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Animation here"),),
      body: Center(child: AnimatedBuilder(animation: _animation, builder: (context,child){
        return Transform.scale(scale: _animation.value,child: child);
      },child: Container(width: 100,height: 100,
        decoration: BoxDecoration(color: Colors.blueAccent,borderRadius: BorderRadius.circular(10)),),
      ),),
    );
  }
}



class AnimationOne extends StatefulWidget {
  const AnimationOne({super.key});

  @override
  State<AnimationOne> createState() => _AnimationOneState();
}

class _AnimationOneState extends State<AnimationOne> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this,duration: Duration(seconds: 1));
    _animation = Tween<double>(begin: 0.3, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.bounceInOut)
    );

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Animation one"),),
      body: Center(
        child: AnimatedBuilder(animation: _animation, builder: (context,child){
          return Transform.scale(scale: _animation.value,child: child);
        },
          child: Container(width: 100,height: 100,color: Colors.red,),),
      ),
    );
  }
}

