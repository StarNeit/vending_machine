enum PrefsKeys {
  vendingMechineKey,
}

extension PrefsKeysExtension on PrefsKeys {
  String get value {
    switch (this) {
      case PrefsKeys.vendingMechineKey:
        return 'VendingMechineKey';
      default:
        return '';
    }
  }
}
