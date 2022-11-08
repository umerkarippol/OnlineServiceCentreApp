import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:onlineservicecentreapp/model/profile_model.dart';
class profilecontroller extends GetxController {
    late List<String> profilee = [];
    late String name,message;
  late bool error;
  var states;
   var result2 ;
   late String status;
   var isDataLoading = false.obs;
getProfile(String id) async {
  
log("otppp");

    try{
      isDataLoading(true);
      http.Response response = await http.post(
          Uri.tryParse('http://192.168.29.59:8080/OnlineServiceApp/profile.jsp')!,
       body: {
          "mbno":id
       }
      );
      if(response.statusCode == 200){
       
         result2 = jsonDecode(response.body);
      print("profil======="+response.body);

    status=result2['msg'];
    log("status ==="+status);
       print("profil======="+result2);
    //   profilee=result2.map((data)=>new Profile.fromJson(data)).toList();
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