class ExtraModel {
  String? statusCode;
  String? statusMessage;
  String? requestId;
  String? maskedPhoneNo;
  String? name;
  DateTime? codeExpiredAt;
  DateTime? resendExpiredAt;
  int? verificationCodeAliveInSeconds;
  int? verificationCodeAllowResendingAfterSeconds;
  // UserRole? userRole;

  ExtraModel({
    this.statusCode,
    this.statusMessage,
    this.requestId,
    this.maskedPhoneNo,
    this.name,
    this.codeExpiredAt,
    this.resendExpiredAt,
    this.verificationCodeAliveInSeconds,
    this.verificationCodeAllowResendingAfterSeconds,
    // this.userRole,
  });

  factory ExtraModel.fromJson(Map<String, dynamic> json) {
    return ExtraModel(
      statusCode: json['statusCode'],
      statusMessage: json['statusMessage'],
      requestId: json['requestId'],
      maskedPhoneNo: json['maskedPhoneNo'],
      name: json['name'],
      codeExpiredAt: json['codeExpiredAt'] != null
          ? DateTime.tryParse(json['codeExpiredAt'])
          : null,
      resendExpiredAt: json['resendExpiredAt'] != null
          ? DateTime.tryParse(json['resendExpiredAt'])
          : null,
      verificationCodeAliveInSeconds: json['verificationCodeAliveInSeconds'],
      verificationCodeAllowResendingAfterSeconds:
          json['verificationCodeAllowResendingAfterSeconds'],
      // userRole: json['userRole'] != null
      //     ? UserRoleUtil.getRole(json['userRole'])
      //     : null,
    );
  }
}
