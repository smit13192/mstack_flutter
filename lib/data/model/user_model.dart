class UserModel {
  String? sId;
  String? username;
  String? email;
  String? password;
  int? age;
  String? createdAt;
  String? updatedAt;

  UserModel({
    this.sId,
    this.username,
    this.email,
    this.password,
    this.age,
    this.createdAt,
    this.updatedAt,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    age = json['age'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['username'] = username;
    data['email'] = email;
    data['password'] = password;
    data['age'] = age;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
