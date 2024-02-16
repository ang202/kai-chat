enum UserRole {
  merchantManager,
  merchantCashier,
}

extension UserRoleUtil on UserRole {
  static UserRole getRole(String? role) {
    switch (role) {
      case 'ROLE_MERCHANT_MANAGER':
        return UserRole.merchantManager;
      case 'ROLE_MERCHANT_CASHIER':
        return UserRole.merchantCashier;
      default:
        return UserRole.merchantCashier;
    }
  }

  static String getName(UserRole role) {
    switch (role) {
      case UserRole.merchantManager:
        return 'ROLE_MERCHANT_MANAGER';
      case UserRole.merchantCashier:
        return 'ROLE_MERCHANT_CASHIER';
      default:
        return '';
    }
  }

  String get name => getName(this);
}
