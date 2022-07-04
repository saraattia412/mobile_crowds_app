
class UsersModel{
  late String name;
  late String email;
  late String uId;
  late String phone;
 late bool isEmailVerified;

  UsersModel({
    required this.email,
    required this.name,
    required this.uId,
    required this.phone,
    required this.isEmailVerified,
});

  UsersModel.fromJson(Map <String , dynamic>? json) {
    email= json!['email'];
    name= json['name'];
    uId= json['uId'];
    phone= json['phone'];
    isEmailVerified=json['isEmailVerified'];
  }

  Map <String , dynamic> toMap(){
    return {
      'name' : name,
      'email' : email,
      'uId' : uId,
      'phone' :phone,
      'isEmailVerified':isEmailVerified,
    };
  }
}





class imageModel{

}


