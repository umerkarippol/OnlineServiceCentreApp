import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:onlineservicecentreapp/controller/profile_controller.dart';
import 'package:onlineservicecentreapp/notification/notification.dart';
import 'package:onlineservicecentreapp/pages/name.dart';
import 'package:onlineservicecentreapp/pages/sharedpreference.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  final prcontroller = Get.put(profilecontroller());
  FirebaseAuth _auth = FirebaseAuth.instance;

  late String verificationId;
  var SharedPreference;

  bool showLoading = false;

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });

      if (authCredential.user != null) {
        if (prcontroller.result2 != null) {
          String aaa = prcontroller.status;

          log("ContsaINDNDDS====" + aaa);

          if (aaa.contains("failed")) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => name(mbno: phoneController.text)));
          } else if (aaa.contains("success")) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyHomePage()));
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });
    }
  }

  getMobileFormWidget(context) {
    return Column(
      children: [
        Spacer(),
        TextField(
          maxLength: 10,
          keyboardType: TextInputType.number,
          controller: phoneController,
          decoration: InputDecoration(
            hintText: "Phone Number",
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextButton(
          onPressed: () async {
            setState(() {
              showLoading = true;
            });

            prcontroller.getProfile(phoneController.text);

            await _auth.verifyPhoneNumber(
              phoneNumber: "+91" + phoneController.text,
              verificationCompleted: (phoneAuthCredential) async {
                setState(() {
                  showLoading = false;
                });
              },
              verificationFailed: (verificationFailed) async {
                setState(() {
                  showLoading = false;
                });
              },
              codeSent: (verificationId, resendingToken) async {
                setState(() {
                  showLoading = false;
                  currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
                  this.verificationId = verificationId;
                });
              },
              codeAutoRetrievalTimeout: (verificationId) async {},
            );
          },
          child: Text(
            "SEND  OTP",
            style: TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue)),
        ),
        Spacer(),
      ],
    );
  }

  getOtpFormWidget(context) {
    return Column(
      children: [
        Spacer(),
        TextField(
          controller: otpController,
          maxLength: 6,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "Enter OTP",
          ),
        ),
        SizedBox(
          height: 16,
        ),
        TextButton(
          onPressed: () async {
            String phone=phoneController.text;
              await UserSimplePreferences.saveUser(phone);
              log("phone--"+phone);
            PhoneAuthCredential phoneAuthCredential =
                PhoneAuthProvider.credential(
                    verificationId: verificationId,
                    smsCode: otpController.text);
            signInWithPhoneAuthCredential(phoneAuthCredential);

          
          },
          child: Text(
            "VERIFY",
            style: TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue)),
        ),
        Spacer(),
      ],
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        key: _scaffoldKey,
        body: Container(
        
          child: showLoading
              ? Center(child: CircularProgressIndicator())
              : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
                  ? getMobileFormWidget(context)
                  : getOtpFormWidget(context),
          padding: const EdgeInsets.all(16),
        ));
  }
}
