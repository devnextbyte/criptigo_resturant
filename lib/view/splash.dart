import 'package:criptigo/view/dashboard.dart';
import 'package:criptigo/util/snippets.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    Future.delayed(Duration(seconds: 2),(){
      push(context, Dashboard());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: (){
            push(context, Dashboard());
          },
          child: Center(
            child: Image.asset(
              "assets/images/logo.png",
              width: MediaQuery.of(context).size.width / 4 * 3,
            ),
          ),
        ),
      ),
    );
  }
}
