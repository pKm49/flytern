class LoginCredential {

  final String email;
  final String password;

  LoginCredential({
    required this.email,
    required this.password,
  });

  Map toJson() => {
    'email': email,
    'password': password,
  };

}

LoginCredential mapLoginCredential(dynamic payload){
  return LoginCredential(
    email :payload["email"]??"",
    password :payload["password"]??"",
  );
}
