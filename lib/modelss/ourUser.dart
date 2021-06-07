class OurUser{

  String uid;
  String phone;
  String name;
  String type;  // customer or trainer
  String gender;
  DateTime dob;
  OurUser({this.phone,this.name,this.type,this.uid, this.dob,this.gender});


  Map<String, dynamic> toMap() {
    return {
      'uid':uid,
      'phone':phone,
      'fullName':name,
      //'email':email,
      'type':type,
      'dob':dob,
    };
  }


  OurUser toInstance(Map<String, dynamic> json) {
    return OurUser(
      uid: json['uid'],
      phone: json['phone'],
      type: json['type'],
      name: json['name'],
      gender: json['gender'],
      dob: json['dob'] != null ? json['dob'].toDate() : json['dob'],
    );
  }
}