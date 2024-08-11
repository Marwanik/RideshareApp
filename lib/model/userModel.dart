import 'dart:convert';

class UserModel {
  String? firstName;
  String? lastName;
  String? phone;
  String? username;
  String? birthDate;
  String? email; // Add email here
  String? password;
  String? confirmPassword;

  UserModel({
    this.firstName,
    this.lastName,
    this.phone,
    this.username,
    this.birthDate,
    this.email, // Add email here
    this.password,
    this.confirmPassword,
  });

  UserModel copyWith({
    String? firstName,
    String? lastName,
    String? phone,
    String? username,
    String? birthDate,
    String? email, // Add email here
    String? password,
    String? confirmPassword,
  }) {
    return UserModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      username: username ?? this.username,
      birthDate: birthDate ?? this.birthDate,
      email: email ?? this.email, // Add email here
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'username': username,
      'birthDate': birthDate,
      'email': email, // Add email here
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      birthDate: map['birthDate'] != null ? map['birthDate'] as String : null,
      email: map['email'] != null ? map['email'] as String : null, // Add email here
      password: map['password'] != null ? map['password'] as String : null,
      confirmPassword: map['confirmPassword'] != null ? map['confirmPassword'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(firstName: $firstName, lastName: $lastName, phone: $phone, username: $username, birthDate: $birthDate, email: $email, password: $password, confirmPassword: $confirmPassword)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.firstName == firstName &&
        other.lastName == lastName &&
        other.phone == phone &&
        other.username == username &&
        other.birthDate == birthDate &&
        other.email == email && 
        other.password == password &&
        other.confirmPassword == confirmPassword;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        phone.hashCode ^
        username.hashCode ^
        birthDate.hashCode ^
        email.hashCode ^ 
        password.hashCode ^
        confirmPassword.hashCode;
  }
}