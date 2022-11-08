import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:onlineservicecentreapp/otp/login_screen.dart';
import 'package:onlineservicecentreapp/pages/sharedpreference.dart';

import '../main.dart';

class MyHomePage extends StatefulWidget {

 /// const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title="aaaa";

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late UserSimplePreferences sharedPreference;
 String? username = UserSimplePreferences.getUsername();
  int _counter = 0;

  @override
  void initState() {
    showNotification();
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('A new onMessageOpenedApp event was published!');

      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title.toString()),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body.toString())],
                  ),
                ),
              );
            });
      }
    });
  }

  Future<void> showNotification() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    var Token = await firebaseMessaging
        .getToken()
        .then((value) => print("Token========  " + value.toString()));
    var mtoken = Token;

    setState(() {
      _counter++;
    });
    flutterLocalNotificationsPlugin.show(
        5,
        "Testing $_counter",
        "How you doin ?",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                channelDescription: channel.description,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: 'favicon.png')));
  }

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    print("username >>>>>> next pageeee  >>>>>>" + username.toString());
    return Scaffold(
      body: Center(
        child: Text("Welcome"),
      ),
    
      floatingActionButton: FloatingActionButton(
        onPressed: () async {

          await UserSimplePreferences.logout();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        },
        
        child: Icon(Icons.logout),
      ),
      
    );
      
  }
}
