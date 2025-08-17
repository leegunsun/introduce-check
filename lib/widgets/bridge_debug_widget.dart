import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../providers/auth_provider.dart';
import '../providers/webview_provider.dart';

/// Comprehensive debug widget for testing JavaScript bridge functionality
class BridgeDebugWidget extends ConsumerStatefulWidget {
  const BridgeDebugWidget({super.key});

  @override
  ConsumerState<BridgeDebugWidget> createState() => _BridgeDebugWidgetState();
}

class _BridgeDebugWidgetState extends ConsumerState<BridgeDebugWidget> {
  final _emailController = TextEditingController(text: 'test@example.com');
  final _passwordController = TextEditingController(text: 'password123');
  final _customJSController = TextEditingController();
  
  String _bridgeTestResults = '';
  bool _isTestingBridge = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _customJSController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bridge Debug'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bridge Status Card
            _buildBridgeStatusCard(authState, authNotifier),
            
            const SizedBox(height: 16),
            
            // Authentication Test Card
            _buildAuthTestCard(authState, authNotifier),
            
            const SizedBox(height: 16),
            
            // JavaScript Bridge Test Card
            _buildJSBridgeTestCard(),
            
            const SizedBox(height: 16),
            
            // Custom JavaScript Execution Card
            _buildCustomJSCard(),
            
            const SizedBox(height: 16),
            
            // Test Results Card
            _buildTestResultsCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildBridgeStatusCard(AuthState authState, AuthNotifier authNotifier) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bridge Status',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            _buildStatusRow('Auth Service Initialized', authState.isInitialized),
            _buildStatusRow('Bridge Service Available', authNotifier.bridgeService.isInitialized),
            _buildStatusRow('User Authenticated', authState.isAuthenticated),
            _buildStatusRow('WebView Ready', ref.read(webViewControllerProvider) != null),
            
            if (authState.user != null) ...[
              const Divider(),
              const Text('User Info:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Email: ${authState.user!.email}'),
              Text('UID: ${authState.user!.uid}'),
              Text('Verified: ${authState.user!.emailVerified}'),
            ],
            
            if (authState.errorMessage != null) ...[
              const Divider(),
              Text(
                'Error: ${authState.errorMessage}',
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAuthTestCard(AuthState authState, AuthNotifier authNotifier) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Authentication Test',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            
            const SizedBox(height: 8),
            
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            
            const SizedBox(height: 12),
            
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: authState.isLoading ? null : () => _testDirectLogin(authNotifier),
                  child: authState.isLoading 
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Direct Login'),
                ),
                ElevatedButton(
                  onPressed: authState.isLoading ? null : () => _testBridgeLogin(),
                  child: const Text('Bridge Login'),
                ),
                ElevatedButton(
                  onPressed: authState.isLoading ? null : () => _testAuthStatus(),
                  child: const Text('Check Status'),
                ),
                ElevatedButton(
                  onPressed: authState.isLoading ? null : () => _testLogout(authNotifier),
                  child: const Text('Logout'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJSBridgeTestCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'JavaScript Bridge Tests',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            
            const Text(
              'These buttons test the JavaScript bridge functions that the website would call:',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            
            const SizedBox(height: 8),
            
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: _isTestingBridge ? null : () => _testJSFunction('startFlutterLogin'),
                  child: const Text('JS Login'),
                ),
                ElevatedButton(
                  onPressed: _isTestingBridge ? null : () => _testJSFunction('checkFlutterAuthStatus'),
                  child: const Text('JS Check Status'),
                ),
                ElevatedButton(
                  onPressed: _isTestingBridge ? null : () => _testJSFunction('flutterLogout'),
                  child: const Text('JS Logout'),
                ),
                ElevatedButton(
                  onPressed: _isTestingBridge ? null : () => _testJSCallback('onFlutterLoginSuccess'),
                  child: const Text('Test Success Callback'),
                ),
                ElevatedButton(
                  onPressed: _isTestingBridge ? null : () => _testJSCallback('onFlutterLoginError'),
                  child: const Text('Test Error Callback'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomJSCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Custom JavaScript Execution',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            
            TextField(
              controller: _customJSController,
              decoration: const InputDecoration(
                labelText: 'JavaScript Code',
                hintText: 'console.log("Hello from custom JS");',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            
            const SizedBox(height: 8),
            
            ElevatedButton(
              onPressed: () => _executeCustomJS(),
              child: const Text('Execute JS'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestResultsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Test Results',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            
            Container(
              width: double.infinity,
              height: 200,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: SingleChildScrollView(
                child: Text(
                  _bridgeTestResults.isEmpty 
                    ? 'Test results will appear here...' 
                    : _bridgeTestResults,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 8),
            
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _bridgeTestResults = '';
                });
              },
              child: const Text('Clear Results'),
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

  void _addTestResult(String result) {
    setState(() {
      final timestamp = DateTime.now().toString().substring(11, 19);
      _bridgeTestResults += '[$timestamp] $result\n';
    });
  }

  Future<void> _testDirectLogin(AuthNotifier authNotifier) async {
    _addTestResult('Testing direct Firebase login...');
    
    final success = await authNotifier.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
    
    _addTestResult('Direct login result: ${success ? "SUCCESS" : "FAILED"}');
    
    if (!success) {
      final error = ref.read(authErrorProvider);
      _addTestResult('Error: $error');
    }
  }

  Future<void> _testBridgeLogin() async {
    _addTestResult('Testing bridge login via JavaScript...');
    
    try {
      final controller = ref.read(webViewControllerProvider);
      final script = '''
        if (typeof window.startFlutterLogin === 'function') {
          window.startFlutterLogin('${_emailController.text.trim()}', '${_passwordController.text}');
          console.log('Bridge login called successfully');
        } else {
          console.log('ERROR: startFlutterLogin function not available');
        }
      ''';
      
      await controller.runJavaScript(script);
      _addTestResult('Bridge login JavaScript executed');
    } catch (e) {
      _addTestResult('Bridge login ERROR: $e');
    }
  }

  Future<void> _testAuthStatus() async {
    _addTestResult('Testing auth status check...');
    
    try {
      final controller = ref.read(webViewControllerProvider);
      final script = '''
        if (typeof window.checkFlutterAuthStatus === 'function') {
          window.checkFlutterAuthStatus();
          console.log('Auth status check called successfully');
        } else {
          console.log('ERROR: checkFlutterAuthStatus function not available');
        }
      ''';
      
      await controller.runJavaScript(script);
      _addTestResult('Auth status check JavaScript executed');
    } catch (e) {
      _addTestResult('Auth status check ERROR: $e');
    }
  }

  Future<void> _testLogout(AuthNotifier authNotifier) async {
    _addTestResult('Testing logout...');
    
    final success = await authNotifier.signOut();
    _addTestResult('Logout result: ${success ? "SUCCESS" : "FAILED"}');
  }

  Future<void> _testJSFunction(String functionName) async {
    setState(() {
      _isTestingBridge = true;
    });
    
    _addTestResult('Testing JavaScript function: $functionName');
    
    try {
      final controller = ref.read(webViewControllerProvider);
      String script = '';
      
      switch (functionName) {
        case 'startFlutterLogin':
          script = '''
            if (typeof window.startFlutterLogin === 'function') {
              window.startFlutterLogin('${_emailController.text}', '${_passwordController.text}');
              'SUCCESS: startFlutterLogin called';
            } else {
              'ERROR: startFlutterLogin not found';
            }
          ''';
          break;
          
        case 'checkFlutterAuthStatus':
          script = '''
            if (typeof window.checkFlutterAuthStatus === 'function') {
              window.checkFlutterAuthStatus();
              'SUCCESS: checkFlutterAuthStatus called';
            } else {
              'ERROR: checkFlutterAuthStatus not found';
            }
          ''';
          break;
          
        case 'flutterLogout':
          script = '''
            if (typeof window.flutterLogout === 'function') {
              window.flutterLogout();
              'SUCCESS: flutterLogout called';
            } else {
              'ERROR: flutterLogout not found';
            }
          ''';
          break;
      }
      
      await controller.runJavaScript(script);
      final result = 'JavaScript executed successfully';
      _addTestResult('$functionName result: $result');
    } catch (e) {
      _addTestResult('$functionName ERROR: $e');
    } finally {
      setState(() {
        _isTestingBridge = false;
      });
    }
  }

  Future<void> _testJSCallback(String callbackName) async {
    _addTestResult('Testing JavaScript callback: $callbackName');
    
    try {
      final controller = ref.read(webViewControllerProvider);
      String script = '';
      
      switch (callbackName) {
        case 'onFlutterLoginSuccess':
          script = '''
            if (typeof window.onFlutterLoginSuccess === 'function') {
              window.onFlutterLoginSuccess('test-token', '{"uid":"test-uid","email":"test@example.com"}');
              'SUCCESS: onFlutterLoginSuccess called';
            } else {
              'ERROR: onFlutterLoginSuccess not found';
            }
          ''';
          break;
          
        case 'onFlutterLoginError':
          script = '''
            if (typeof window.onFlutterLoginError === 'function') {
              window.onFlutterLoginError('test-error', 'Test error message');
              'SUCCESS: onFlutterLoginError called';
            } else {
              'ERROR: onFlutterLoginError not found';
            }
          ''';
          break;
      }
      
      await controller.runJavaScript(script);
      final result = 'JavaScript executed successfully';
      _addTestResult('$callbackName result: $result');
    } catch (e) {
      _addTestResult('$callbackName ERROR: $e');
    }
  }

  Future<void> _executeCustomJS() async {
    if (_customJSController.text.trim().isEmpty) {
      _addTestResult('ERROR: No JavaScript code provided');
      return;
    }
    
    _addTestResult('Executing custom JavaScript...');
    
    try {
      final controller = ref.read(webViewControllerProvider);
      await controller.runJavaScript(_customJSController.text);
      _addTestResult('Custom JS executed successfully');
    } catch (e) {
      _addTestResult('Custom JS ERROR: $e');
    }
  }
}