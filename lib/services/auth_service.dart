import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

/// Firebase Authentication Service with WebView Bridge Integration
class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final StreamController<User?> _authStateController = StreamController<User?>.broadcast();
  
  /// Current authenticated user
  User? get currentUser => _auth.currentUser;
  
  /// Authentication state stream
  Stream<User?> get authStateChanges => _authStateController.stream;
  
  /// Initialize authentication service
  Future<void> initialize() async {
    debugPrint('🔐 Initializing AuthService...');
    
    // Listen to auth state changes
    _auth.authStateChanges().listen((User? user) {
      debugPrint('🔐 Auth state changed: ${user?.email ?? 'null'}');
      _authStateController.add(user);
    });
    
    debugPrint('🔐 AuthService initialized');
  }

  /// Sign in with email and password
  Future<AuthResult> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      debugPrint('🔐 Attempting sign in for: $email');
      
      final UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      final user = credential.user;
      if (user != null) {
        debugPrint('🔐 ✅ Sign in successful');
        
        // Get ID token for the bridge
        final idToken = await user.getIdToken();
        
        return AuthResult.success(
          user: user,
          token: idToken,
        );
      } else {
        debugPrint('🔐 ❌ Sign in failed: User is null');
        return AuthResult.error(
          code: 'user-null',
          message: 'User is null after authentication',
        );
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('🔐 ❌ FirebaseAuth error: ${e.code} - ${e.message}');
      return AuthResult.error(
        code: e.code,
        message: e.message ?? 'Authentication failed',
      );
    } catch (e) {
      debugPrint('🔐 ❌ Unexpected error: $e');
      return AuthResult.error(
        code: 'unknown-error',
        message: 'An unexpected error occurred',
      );
    }
  }

  /// Sign out current user
  Future<AuthResult> signOut() async {
    try {
      debugPrint('🔐 Signing out...');
      await _auth.signOut();
      debugPrint('🔐 ✅ Sign out successful');
      return AuthResult.success();
    } catch (e) {
      debugPrint('🔐 ❌ Sign out error: $e');
      return AuthResult.error(
        code: 'signout-error',
        message: 'Failed to sign out',
      );
    }
  }

  /// Check current authentication status
  Future<AuthStatusResult> getAuthStatus() async {
    try {
      final user = currentUser;
      
      if (user != null) {
        // Refresh token to ensure it's valid
        await user.reload();
        final updatedUser = _auth.currentUser;
        
        if (updatedUser != null) {
          final token = await updatedUser.getIdToken();
          return AuthStatusResult(
            isAuthenticated: true,
            user: updatedUser,
            token: token,
          );
        }
      }
      
      return AuthStatusResult(isAuthenticated: false);
    } catch (e) {
      debugPrint('🔐 ❌ Auth status check error: $e');
      return AuthStatusResult(isAuthenticated: false);
    }
  }

  /// Create user account with email and password
  Future<AuthResult> createUserWithEmailAndPassword({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      debugPrint('🔐 Creating account for: $email');
      
      final UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      final user = credential.user;
      if (user != null) {
        // Update display name if provided
        if (displayName != null && displayName.isNotEmpty) {
          await user.updateDisplayName(displayName);
        }
        
        // Get ID token
        final idToken = await user.getIdToken();
        
        debugPrint('🔐 ✅ Account created successfully');
        return AuthResult.success(
          user: user,
          token: idToken,
        );
      } else {
        return AuthResult.error(
          code: 'user-null',
          message: 'User is null after account creation',
        );
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('🔐 ❌ Account creation error: ${e.code} - ${e.message}');
      return AuthResult.error(
        code: e.code,
        message: e.message ?? 'Account creation failed',
      );
    } catch (e) {
      debugPrint('🔐 ❌ Unexpected error: $e');
      return AuthResult.error(
        code: 'unknown-error',
        message: 'An unexpected error occurred',
      );
    }
  }

  /// Send password reset email
  Future<AuthResult> sendPasswordResetEmail(String email) async {
    try {
      debugPrint('🔐 Sending password reset email to: $email');
      await _auth.sendPasswordResetEmail(email: email);
      debugPrint('🔐 ✅ Password reset email sent');
      return AuthResult.success();
    } on FirebaseAuthException catch (e) {
      debugPrint('🔐 ❌ Password reset error: ${e.code} - ${e.message}');
      return AuthResult.error(
        code: e.code,
        message: e.message ?? 'Failed to send password reset email',
      );
    } catch (e) {
      debugPrint('🔐 ❌ Unexpected error: $e');
      return AuthResult.error(
        code: 'unknown-error',
        message: 'An unexpected error occurred',
      );
    }
  }

  /// Convert User to JSON for bridge communication
  Map<String, dynamic> userToJson(User user) {
    return {
      'uid': user.uid,
      'email': user.email,
      'displayName': user.displayName,
      'photoURL': user.photoURL,
      'emailVerified': user.emailVerified,
      'phoneNumber': user.phoneNumber,
      'creationTime': user.metadata.creationTime?.toIso8601String(),
      'lastSignInTime': user.metadata.lastSignInTime?.toIso8601String(),
    };
  }

  /// Dispose resources
  void dispose() {
    _authStateController.close();
  }
}

/// Authentication result class
class AuthResult {
  final bool success;
  final User? user;
  final String? token;
  final String? errorCode;
  final String? errorMessage;

  AuthResult._({
    required this.success,
    this.user,
    this.token,
    this.errorCode,
    this.errorMessage,
  });

  factory AuthResult.success({User? user, String? token}) {
    return AuthResult._(
      success: true,
      user: user,
      token: token,
    );
  }

  factory AuthResult.error({
    required String code,
    required String message,
  }) {
    return AuthResult._(
      success: false,
      errorCode: code,
      errorMessage: message,
    );
  }

  @override
  String toString() {
    if (success) {
      return 'AuthResult(success: true, user: ${user?.email})';
    } else {
      return 'AuthResult(success: false, error: $errorCode - $errorMessage)';
    }
  }
}

/// Authentication status result
class AuthStatusResult {
  final bool isAuthenticated;
  final User? user;
  final String? token;

  AuthStatusResult({
    required this.isAuthenticated,
    this.user,
    this.token,
  });

  Map<String, dynamic> toJson() {
    return {
      'isAuthenticated': isAuthenticated,
      'user': user != null ? AuthService().userToJson(user!) : null,
      'token': token,
    };
  }
}