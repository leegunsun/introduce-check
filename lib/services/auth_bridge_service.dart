import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'auth_service.dart';

/// Bridge service for handling authentication between WebView and Flutter
class AuthBridgeService {
  static final AuthBridgeService _instance = AuthBridgeService._internal();
  factory AuthBridgeService() => _instance;
  AuthBridgeService._internal();

  final AuthService _authService = AuthService();
  WebViewController? _webViewController;
  bool _isInitialized = false;

  /// Initialize the bridge service with WebViewController
  Future<void> initialize(WebViewController controller) async {
    debugPrint('🌉 Initializing AuthBridgeService...');
    
    _webViewController = controller;
    
    // Initialize auth service
    await _authService.initialize();
    
    // Setup JavaScript bridge functions
    await _setupJavaScriptBridge();
    
    // Listen to auth state changes and notify WebView
    _authService.authStateChanges.listen((user) {
      _notifyAuthStateChange(user != null);
    });
    
    _isInitialized = true;
    debugPrint('🌉 ✅ AuthBridgeService initialized');
  }

  /// Setup JavaScript bridge functions in WebView
  Future<void> _setupJavaScriptBridge() async {
    if (_webViewController == null) return;

    try {
      // Add JavaScript channel for Flutter → JavaScript communication
      _webViewController!.addJavaScriptChannel(
        'FlutterAuthChannel',
        onMessageReceived: (JavaScriptMessage message) {
          _handleJavaScriptMessage(message.message);
        },
      );
      
      debugPrint('🌉 ✅ JavaScript channel setup complete');
    } catch (e) {
      debugPrint('🌉 ❌ Error setting up JavaScript channel: $e');
    }
  }

  /// Inject JavaScript bridge functions into the WebView
  Future<void> injectJavaScriptFunctions() async {
    if (_webViewController == null) return;

    try {
      const String bridgeScript = '''
        // Flutter Authentication Bridge Functions
        window.startFlutterLogin = function(email, password) {
          FlutterAuthChannel.postMessage(JSON.stringify({
            action: 'startLogin',
            data: { email: email, password: password }
          }));
        };
        
        window.checkFlutterAuthStatus = function() {
          FlutterAuthChannel.postMessage(JSON.stringify({
            action: 'checkAuthStatus',
            data: {}
          }));
        };
        
        window.flutterLogout = function() {
          FlutterAuthChannel.postMessage(JSON.stringify({
            action: 'logout',
            data: {}
          }));
        };
        
        // Register callback functions that Flutter can call
        window.onFlutterLoginSuccess = window.onFlutterLoginSuccess || function(token, userData) {
          console.log('🔐 Login success received from Flutter');
        };
        
        window.onFlutterLoginError = window.onFlutterLoginError || function(errorCode, errorMessage) {
          console.log('🔐 Login error received from Flutter:', errorCode, errorMessage);
        };
        
        window.onFlutterAuthStatus = window.onFlutterAuthStatus || function(isAuthenticated) {
          console.log('🔐 Auth status received from Flutter:', isAuthenticated);
        };
        
        window.onFlutterLogout = window.onFlutterLogout || function() {
          console.log('🔐 Logout completed from Flutter');
        };
        
        console.log('🌉 Flutter Auth Bridge functions injected');
      ''';

      await _webViewController!.runJavaScript(bridgeScript);
      debugPrint('🌉 ✅ JavaScript bridge functions injected');
    } catch (e) {
      debugPrint('🌉 ❌ Error injecting JavaScript functions: $e');
    }
  }

  /// Handle messages received from JavaScript
  void _handleJavaScriptMessage(String message) async {
    try {
      debugPrint('🌉 📨 Received message from JavaScript: $message');
      
      final Map<String, dynamic> data = jsonDecode(message);
      final String action = data['action'] ?? '';
      final Map<String, dynamic> payload = data['data'] ?? {};

      switch (action) {
        case 'startLogin':
          await _handleLogin(payload);
          break;
        case 'checkAuthStatus':
          await _handleAuthStatusCheck(payload);
          break;
        case 'logout':
          await _handleLogout(payload);
          break;
        default:
          debugPrint('🌉 ❓ Unknown action: $action');
          break;
      }
    } catch (e) {
      debugPrint('🌉 ❌ Error handling JavaScript message: $e');
    }
  }

  /// Handle login request from WebView
  Future<void> _handleLogin(Map<String, dynamic> params) async {
    try {
      debugPrint('🌉 🔐 Handling login request: $params');
      
      final String? email = params['email']?.toString();
      final String? password = params['password']?.toString();
      
      if (email == null || password == null || email.isEmpty || password.isEmpty) {
        _notifyLoginError('invalid-credentials', 'Email and password are required');
        return;
      }
      
      final result = await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      if (result.success && result.user != null && result.token != null) {
        _notifyLoginSuccess(result.token!, result.user!);
      } else {
        _notifyLoginError(
          result.errorCode ?? 'unknown-error',
          result.errorMessage ?? 'Login failed',
        );
      }
    } catch (e) {
      debugPrint('🌉 ❌ Login handler error: $e');
      _notifyLoginError('unexpected-error', 'An unexpected error occurred');
    }
  }

  /// Handle auth status check request from WebView
  Future<void> _handleAuthStatusCheck(Map<String, dynamic> params) async {
    try {
      debugPrint('🌉 🔍 Checking auth status...');
      
      final statusResult = await _authService.getAuthStatus();
      _notifyAuthStatusCheck(statusResult.isAuthenticated);
    } catch (e) {
      debugPrint('🌉 ❌ Auth status check error: $e');
      _notifyAuthStatusCheck(false);
    }
  }

  /// Handle logout request from WebView
  Future<void> _handleLogout(Map<String, dynamic> params) async {
    try {
      debugPrint('🌉 🚪 Handling logout request...');
      
      final result = await _authService.signOut();
      
      if (result.success) {
        _notifyLogout();
      } else {
        debugPrint('🌉 ❌ Logout failed: ${result.errorMessage}');
      }
    } catch (e) {
      debugPrint('🌉 ❌ Logout handler error: $e');
    }
  }

  /// Notify WebView of successful login
  void _notifyLoginSuccess(String token, dynamic user) {
    if (_webViewController == null) return;
    
    try {
      final userDataJson = jsonEncode(_authService.userToJson(user));
      final script = '''
        if (typeof window.onFlutterLoginSuccess === 'function') {
          window.onFlutterLoginSuccess('$token', '$userDataJson');
        }
      ''';
      
      _webViewController!.runJavaScript(script);
      debugPrint('🌉 ✅ Login success notified to WebView');
    } catch (e) {
      debugPrint('🌉 ❌ Error notifying login success: $e');
    }
  }

  /// Notify WebView of login error
  void _notifyLoginError(String errorCode, String errorMessage) {
    if (_webViewController == null) return;
    
    try {
      final script = '''
        if (typeof window.onFlutterLoginError === 'function') {
          window.onFlutterLoginError('$errorCode', '$errorMessage');
        }
      ''';
      
      _webViewController!.runJavaScript(script);
      debugPrint('🌉 ❌ Login error notified to WebView: $errorCode');
    } catch (e) {
      debugPrint('🌉 ❌ Error notifying login error: $e');
    }
  }

  /// Notify WebView of auth status
  void _notifyAuthStatusCheck(bool isAuthenticated) {
    if (_webViewController == null) return;
    
    try {
      final script = '''
        if (typeof window.onFlutterAuthStatus === 'function') {
          window.onFlutterAuthStatus($isAuthenticated);
        }
      ''';
      
      _webViewController!.runJavaScript(script);
      debugPrint('🌉 📊 Auth status notified to WebView: $isAuthenticated');
    } catch (e) {
      debugPrint('🌉 ❌ Error notifying auth status: $e');
    }
  }

  /// Notify WebView of auth state change
  void _notifyAuthStateChange(bool isAuthenticated) {
    if (_webViewController == null) return;
    
    try {
      final script = '''
        if (typeof window.onFlutterAuthStatus === 'function') {
          window.onFlutterAuthStatus($isAuthenticated);
        }
      ''';
      
      _webViewController!.runJavaScript(script);
      debugPrint('🌉 📊 Auth state change notified to WebView: $isAuthenticated');
    } catch (e) {
      debugPrint('🌉 ❌ Error notifying auth state change: $e');
    }
  }

  /// Notify WebView of logout
  void _notifyLogout() {
    if (_webViewController == null) return;
    
    try {
      final script = '''
        if (typeof window.onFlutterLogout === 'function') {
          window.onFlutterLogout();
        }
      ''';
      
      _webViewController!.runJavaScript(script);
      debugPrint('🌉 🚪 Logout notified to WebView');
    } catch (e) {
      debugPrint('🌉 ❌ Error notifying logout: $e');
    }
  }

  /// Check if bridge is initialized
  bool get isInitialized => _isInitialized;

  /// Get current auth service
  AuthService get authService => _authService;
}