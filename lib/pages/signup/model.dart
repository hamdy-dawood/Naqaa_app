class SignUpResp {
  String? userName;
  String? userEmail;
  String? userPassword;
  String? userPhone;
  int? userStatus;
  int? userVerifyCode;

  SignUpResp(
      {this.userName,
      this.userEmail,
      this.userPassword,
      this.userPhone,
      this.userStatus,
      this.userVerifyCode});

  SignUpResp.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    userEmail = json['user_email'];
    userPassword = json['user_password'];
    userPhone = json['user_phone'];
    userStatus = json['user_status'];
    userVerifyCode = json['user_verifycode'];
  }
}
