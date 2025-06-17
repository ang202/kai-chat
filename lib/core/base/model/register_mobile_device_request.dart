class RegisterMobileDeviceRequest {
  String? deviceToken;
  String? model;
  String? platform;
  String? uuid;
  String? osVersion;
  String? manufacturer;
  bool? virtual;
  String? serial;

  RegisterMobileDeviceRequest({
    this.deviceToken,
    this.model,
    this.platform,
    this.uuid,
    this.osVersion,
    this.manufacturer,
    this.virtual,
    this.serial,
  });

  factory RegisterMobileDeviceRequest.fromJson(Map<String, dynamic> json) =>
      RegisterMobileDeviceRequest(
        deviceToken: json["deviceToken"],
        model: json["model"],
        platform: json["platform"],
        uuid: json["uuid"],
        osVersion: json["osVersion"],
        manufacturer: json["manufacturer"],
        virtual: json["virtual"],
        serial: json["serial"],
      );

  Map<String, dynamic> toJson() => {
        "deviceToken": deviceToken,
        "model": model,
        "platform": platform,
        "uuid": uuid,
        "osVersion": osVersion,
        "manufacturer": manufacturer,
        "virtual": virtual,
        "serial": serial,
      }..removeWhere((dynamic key, dynamic value) =>
          key == null || value == null || value == "null");
}
