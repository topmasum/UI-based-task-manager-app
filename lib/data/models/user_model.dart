class user{
  late String id;
  late String email;
  late String firstName;
  late String lastName;
  late String mobile;
   String? photo;

  String get fullnaem{
    return '$firstName '
        '$lastName';
  }
  user.fromjson(Map<String, dynamic> jsonData) {
    id = jsonData['_id'];
    email = jsonData['email'];
    firstName = jsonData['firstName'];
    lastName = jsonData['lastName'];
    mobile = jsonData['mobile'];
    photo = jsonData['photo'];
  }
  Map<String, dynamic> toJson() {
    return{
      '_id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'mobile': mobile,
      'photo': photo,
    };
}
}