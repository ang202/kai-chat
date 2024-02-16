abstract class ApiConstants {
  static const List<int> unauthorizedStatusCode = [401, 3];
  static const connectTimeoutInMs = 20;
  static const receiveTimeoutInMs = 15;
  static const contentTypeJson = 'application/json';
  // static const httpMaintenanceModeStatusCode = [
  //   HttpStatus.badGateway,
  //   HttpStatus.serviceUnavailable,
  //   523,
  //   522
  // ];
  static const httpUnauthorizedIgnoreUrl = ['/auth/logout'];
  static const httpMaintenanceIgnoreUrl = ['/auth/version'];
  static const isAuthenticated = '/cus/auth/isAuthenticated';

  /// Authentication Constant
  static const lUK = '2FJWa3hRFt';
  static const lPK = 'L2vQczOEsY';
  static const secret = 'BqxTAjdNg';

  // API lists
  static const projectDetailsUri = '/repos/';
  static const loginApi = '/cus/auth/login';
  static const logout = '/cus/auth/logout';
  static const registerUser = '/users/form/submitUserFormRequest';
  static const changePassword = '/cus/auth/changeMyPassword';
  static const isMobileDeviceVerified = '/mobileDevices/isVerified';
  static const registerMobileDevice = '/mobileDevices/register';
  static const verifyMobileDevice = '/mobileDevices/verify';
  static const chatCompletions = '/chat/completions';

  // Currency code
  static const malaysianRinggitCode = '458';
  static const generalDecimalPlace = '2';

  /// Numeric constants
  static const maxImageSize = 307200;

  /// Http Error Code
  static const itemNotFound = 9;
}
