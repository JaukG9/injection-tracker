import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../core/constants/app_constants.dart';

/// The lock gate shown when the app lock is enabled and the session is not yet
/// authenticated. Tries biometrics first, with a PIN fallback.
class LockScreen extends ConsumerStatefulWidget {
  const LockScreen({super.key});

  @override
  ConsumerState<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends ConsumerState<LockScreen> {
  final _pin = TextEditingController();
  String? _error;
  bool _triedBiometric = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _tryBiometric());
  }

  @override
  void dispose() {
    _pin.dispose();
    super.dispose();
  }

  void _unlock() => ref.read(authenticatedProvider.notifier).unlock();

  Future<void> _tryBiometric() async {
    if (_triedBiometric) return;
    _triedBiometric = true;
    final auth = ref.read(authServiceProvider);
    if (await auth.biometricEnabled() && await auth.canUseBiometrics()) {
      if (await auth.authenticateBiometric()) _unlock();
    }
  }

  Future<void> _submitPin() async {
    final ok = await ref.read(authServiceProvider).verifyPin(_pin.text.trim());
    if (ok) {
      _unlock();
    } else {
      setState(() => _error = 'Incorrect PIN');
      _pin.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock_outline,
                      size: 48, color: theme.colorScheme.primary),
                  const SizedBox(height: 16),
                  Text(AppConstants.appName,
                      style: theme.textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text('Enter your PIN to unlock',
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: theme.colorScheme.outline)),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _pin,
                    autofocus: true,
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 8,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    style: const TextStyle(fontSize: 24, letterSpacing: 8),
                    decoration: InputDecoration(
                      counterText: '',
                      errorText: _error,
                      hintText: '••••',
                    ),
                    onSubmitted: (_) => _submitPin(),
                    onChanged: (_) {
                      if (_error != null) setState(() => _error = null);
                    },
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: _submitPin,
                    child: const Text('Unlock'),
                  ),
                  const SizedBox(height: 12),
                  TextButton.icon(
                    onPressed: () {
                      _triedBiometric = false;
                      _tryBiometric();
                    },
                    icon: const Icon(Icons.fingerprint),
                    label: const Text('Use biometrics'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
