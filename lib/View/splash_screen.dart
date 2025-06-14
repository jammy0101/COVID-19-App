import 'dart:async';
import 'package:covid_tracker/View/world_states.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

late final AnimationController controller = AnimationController(
    vsync: this,
  duration: Duration(seconds: 3),
)..repeat();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    Timer(Duration(seconds: 3), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => WorldStates()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            AnimatedBuilder(
                animation: controller,
                child:  Center(
                  child: Container(
                    height: 200,
                    width: 200,
                    child: Center(
                      child: Image(image: ExactAssetImage('images/virus.png')),
                    ),
                  ),
                ),
                builder: (BuildContext context,Widget? child){
                  return Transform.rotate(
                      angle: controller.value * 2.0 * math.pi,
                    child: child,
                  );
                }
            ),
            SizedBox(height: 5,),
            Align(
              alignment: Alignment.center,
                child: Text('Covid-19\nTracker App',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),))
          ],
        ),
      ),
    );
  }
}
