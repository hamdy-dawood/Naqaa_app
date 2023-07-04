class ProfileDataResp {
  int? userId;
  String? userName;
  String? userEmail;
  String? userPassword;
  String? userPhone;
  int? userStatus;
  String? userVerifyCode;
  String? userTime;

  ProfileDataResp({
    this.userId,
    this.userName,
    this.userEmail,
    this.userPassword,
    this.userPhone,
    this.userStatus,
    this.userVerifyCode,
    this.userTime,
  });

  ProfileDataResp.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'] ?? 0;
    userName = json['user_name'] ?? "";
    userEmail = json['user_email'] ?? "";
    userPassword = json['user_password'] ?? "";
    userPhone = json['user_phone'] ?? "";
    userStatus = json['user_status'] ?? 0;
    userVerifyCode = json['user_verifycode'] ?? "";
    userTime = json['user_time'] ?? "";
  }
}
