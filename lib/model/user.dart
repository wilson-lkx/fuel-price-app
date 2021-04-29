class User{
  final int id;
  final String email;
  final String password;
  final String salt;

  User({this.id, this.email, this.password, this.salt});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      salt: json['salt'],
    );
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this.id;
    data['email'] = this.email;
    data['password'] = this.password;
    data['salt'] = this.salt;
    return data;
  }
}