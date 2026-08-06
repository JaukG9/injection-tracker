import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

/// Handles the app lock: a PIN (stored as a salted SHA-256 hash in the
/// platform secure storage) with optional biometric unlock.
class AuthService {
  AuthService({
    FlutterSecureStorage? storage,
    LocalAuthentication? localAuth,
  })  : _storage = storage ?? const FlutterSecureStorage(),
        _localAuth = localAuth ?? LocalAuthentication();

  final FlutterSecureStorage _storage;
  final LocalAuthentication _localAuth;

  static const _kHash = 'pin_hash';
  static const _kSalt = 'pin_salt';
  static const _kBiometric = 'biometric_enabled';

  // --- PIN ---

  Future<bool> hasPin() async => (await _storage.read(key: _kHash)) != null;

  Future<void> setPin(String pin) async {
    final salt = _newSalt();
    await _storage.write(key: _kSalt, value: salt);
    await _storage.write(key: _kHash, value: _hash(pin, salt));
  }

  Future<bool> verifyPin(String pin) async {
    final salt = await _storage.read(key: _kSalt);
    final hash = await _storage.read(key: _kHash);
    if (salt == null || hash == null) return false;
    return _constantTimeEquals(_hash(pin, salt), hash);
  }

  Future<void> clearPin() async {
    await _storage.delete(key: _kHash);
    await _storage.delete(key: _kSalt);
    await _storage.delete(key: _kBiometric);
  }

  // --- Biometrics ---

  Future<bool> biometricEnabled() async =>
      (await _storage.read(key: _kBiometric)) == 'true';

  Future<void> setBiometricEnabled(bool value) =>
      _storage.write(key: _kBiometric, value: value ? 'true' : 'false');

  Future<bool> canUseBiometrics() async {
    try {
      final supported = await _localAuth.isDeviceSupported();
      final canCheck = await _localAuth.canCheckBiometrics;
      return supported && canCheck;
    } catch (_) {
      return false;
    }
  }

  Future<bool> authenticateBiometric() async {
    try {
      return await _localAuth.authenticate(
        localizedReason: 'Unlock SiteCycle',
        biometricOnly: true,
        persistAcrossBackgrounding: true,
      );
    } catch (_) {
      return false;
    }
  }

  // --- Helpers ---

  String _newSalt() {
    final rnd = Random.secure();
    final bytes = List<int>.generate(16, (_) => rnd.nextInt(256));
    return base64Url.encode(bytes);
  }

  String _hash(String pin, String salt) =>
      sha256.convert(utf8.encode('$salt:$pin')).toString();

  bool _constantTimeEquals(String a, String b) {
    if (a.length != b.length) return false;
    var result = 0;
    for (var i = 0; i < a.length; i++) {
      result |= a.codeUnitAt(i) ^ b.codeUnitAt(i);
    }
    return result == 0;
  }
}
