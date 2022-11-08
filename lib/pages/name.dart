import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:onlineservicecentreapp/controller/name_controller.dart';

class name extends StatefulWidget {
  String mbno;
name({
  required this.mbno
});

  @override
  State<name> createState() => _nameState();
}

class _nameState extends State<name> {
  final nacontroller = Get.put(namecontroller());
  TextEditingController name=new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('Online service centre'),
        // ),
        body: Padding(
            padding: EdgeInsets.all(15),
            child: Center(
              child: SingleChildScrollView(
              child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextField(
                      
                      controller: name,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: ' Name',
                        hintText: 'Enter Your Name',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    child: Text('OK'),
                    onPressed: () {
                 log("clicked =====");
   nacontroller.postName(name.text,widget.mbno);
  
                    //  log("message==="+nacontroller.msg!);
///
  //                    if (nacontroller.isDataLoading.value){
                        
     
  //  }else{


   
  //   Navigator.push(
  //                     context,
  //                     MaterialPageRoute(builder: (context) => MyHomePage()),
  //                   );

  //   }                
                    },
                  )
                ],
              ),
            ))
    ));
  }
}
