class UserModel {
  String? name;
  String? email;
  String? uId;
  String? image;
  String? bio;
  String? myToken;
  UserModel({
    this.name,
    this.email,
    this.uId,
    this.image,
    this.bio,
    this.myToken,
  });
  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    uId = json['uId'];
    image = json['image'];
    bio = json['bio'];
    myToken = json['myToken'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'uId': uId,
      'image': image,
      'bio': bio,
      'myToken': myToken,
    };
  }
}
