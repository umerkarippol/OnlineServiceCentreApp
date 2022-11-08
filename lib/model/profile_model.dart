class Profile {
  late String name;
  late String address;
  late String phone;
  late String genter;
  late String email;
  late String username;
  late String district;
  late String taluk;
  late String panchayath;
  late String onlineservicecentre;

  Profile({
    
    required this.name,
    required this.address,
    required this.phone,
    required this.genter,
    required this.email,
    required this.username,
    required this.district,
    required this.taluk,
    required this.panchayath,
    required this.onlineservicecentre,
  });
  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
        name: json['name'],
        address: json['address'],
        phone: json['phone'],
        genter: json['genter'],
        email: json['email'],
        username: json['username'],
        district: json['district'],
        taluk: json['taluk'],
        panchayath: json['panchayath'],
        onlineservicecentre: json['onlineservicecentre']);
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "phone": phone,
        "genter": genter,
        "email": email,
        "username": username,
        "district": district,
        "taluk": taluk,
        "panchayath": panchayath,
        "onlineservicecentre": onlineservicecentre
      };
}
