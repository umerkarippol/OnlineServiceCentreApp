import 'dart:async';
import 'package:flutter/material.dart';
import 'package:onlineservicecentreapp/loginpage.dart';


class Splash extends StatefulWidget {
@override
_SplashState createState() => _SplashState();
}
class _SplashState extends State<Splash> {
@override
void initState() {
	super.initState();
	Timer(Duration(seconds: 3),
		()=>
    
    Navigator.pushReplacement(context,
										MaterialPageRoute(builder:
														(context) =>
														loginpage()
														)
									)
		);
}
@override
Widget build(BuildContext context) {
	return Container(
	color: Colors.white,
  child:Center(child: Column(
    children: [
      Padding(padding: EdgeInsets.only(top: 100)),
      Image.asset("assets/logo.png"),
      
    ],
)
  )
	);
}
}
