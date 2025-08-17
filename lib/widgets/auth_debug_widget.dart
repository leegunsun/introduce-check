import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import 'bridge_debug_widget.dart';

/// Debug widget for testing authentication functionality
class AuthDebugWidget extends ConsumerWidget {
  const AuthDebugWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Auth Debug'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Authentication Status
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Authentication Status',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    _buildStatusRow('Initialized', authState.isInitialized),
                    _buildStatusRow('Loading', authState.isLoading),
                    _buildStatusRow('Authenticated', authState.isAuthenticated),
                    if (authState.user != null) ...[
                      const SizedBox(height: 8),
                      Text('User: ${authState.user!.email}'),
                      Text('UID: ${authState.user!.uid}'),
                      Text('Verified: ${authState.user!.emailVerified}'),
                    ],
                    if (authState.errorMessage != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Error: ${authState.errorMessage}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Bridge Status
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bridge Status',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    _buildStatusRow(
                      'Bridge Initialized', 
                      authNotifier.bridgeService.isInitialized
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Action Buttons
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: authState.isLoading ? null : () {
                    _testLogin(context, ref);
                  },
                  child: const Text('Test Login'),
                ),
                ElevatedButton(
                  onPressed: authState.isLoading ? null : () {
                    authNotifier.signOut();
                  },
                  child: const Text('Logout'),
                ),
                ElevatedButton(
                  onPressed: authState.isLoading ? null : () {
                    _testAuthStatus(ref);
                  },
                  child: const Text('Check Auth Status'),
                ),
                ElevatedButton(
                  onPressed: authState.errorMessage != null ? () {
                    authNotifier.clearError();
                  } : null,
                  child: const Text('Clear Error'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const BridgeDebugWidget(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.code),
                  label: const Text('Bridge Debug'),
                ),
              ],
            ),
            
            if (authState.isLoading)
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusRow(String label, bool status) {
    return Row(
      children: [
        Icon(
          status ? Icons.check_circle : Icons.cancel,
          color: status ? Colors.green : Colors.red,
          size: 16,
        ),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }

  void _testLogin(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => _LoginDialog(ref: ref),
    );
  }

  void _testAuthStatus(WidgetRef ref) async {
    final authNotifier = ref.read(authProvider.notifier);
    final status = await authNotifier.getAuthStatus();
    debugPrint('Auth Status: ${status.toJson()}');
  }
}

class _LoginDialog extends StatefulWidget {
  final WidgetRef ref;
  
  const _LoginDialog({required this.ref});

  @override
  State<_LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<_LoginDialog> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Test Login'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              hintText: 'test@example.com',
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
            obscureText: true,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _performLogin,
          child: _isLoading 
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Text('Login'),
        ),
      ],
    );
  }

  void _performLogin() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter email and password')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final authNotifier = widget.ref.read(authProvider.notifier);
    final success = await authNotifier.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if (success) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login successful!')),
      );
    } else {
      final error = widget.ref.read(authErrorProvider);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $error')),
      );
    }
  }
}