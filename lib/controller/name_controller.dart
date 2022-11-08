import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:onlineservicecentreapp/model/profile_model.dart';
import 'package:onlineservicecentreapp/pages/name.dart';
import 'package:onlineservicecentreapp/notification/notification.dart';
class namecontroller extends GetxController {
    late List<String> profilee = [];
       String? msg,message;
 
   var result2 ;
   
   var isDataLoading = false.obs;



postName(String name,String mbno) async {
  

    try{
      isDataLoading(true);
      http.Response response = await http.post(
          Uri.tryParse('http://192.168.29.59:8080/OnlineServiceApp/postname.jsp')!,
       body: {
          "name":name,
          "mbno":mbno
       }
      );
      if(response.statusCode == 200){
       
         result2 = jsonDecode(response.body);
      log("namee======="+response.body);
      msg=result2['msg'];
       Get.to(() => MyHomePage());

   
      }else{
       
      }
    }catch(e){
      log('Error while getting data is $e');
      print('Error while getting data is $e');
    }finally{
      isDataLoading(false);
    }
  }
}