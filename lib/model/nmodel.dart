class cmodel{
  late String msg;

cmodel({
  required this.msg
});
 factory cmodel.fromJson(Map<String, dynamic> json) {
    return cmodel(
        msg: json['msg']
    );
     }

  Map<String, dynamic> toJson() => {
        "msg": msg
  };
  
}