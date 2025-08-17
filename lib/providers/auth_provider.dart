import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth_service.dart';
import '../services/auth_bridge_service.dart';

/// Authentication state data class
class AuthState {
  final User? user;
  final bool isLoading;
  final bool isInitialized;
  final String? errorMessage;

  const AuthState({
    this.user,
    required this.isLoading,
    required this.isInitialized,
    this.errorMessage,
  });

  bool get isAuthenticated => user != null;

  AuthState copyWith({
    User? user,
    bool? isLoading,
    bool? isInitialized,
    String? errorMessage,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      isInitialized: isInitialized ?? this.isInitialized,
      errorMessage: errorMessage,
    );
  }

  AuthState clearError() {
    return copyWith(errorMessage: null);
  }

  @override
  String toString() {
    return 'AuthState(user: ${user?.email}, isLoading: $isLoading, isInitialized: $isInitialized, error: $errorMessage)';
  }
}

/// Authentication state notifier
class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState(
    isLoading: false,
    isInitialized: false,
  )) {
    _initialize();
  }

  final AuthService _authService = AuthService();
  final AuthBridgeService _bridgeService = AuthBridgeService();

  /// Initialize authentication
  Future<void> _initialize() async {
    try {
      state = state.copyWith(isLoading: true);
      
      await _authService.initialize();
      
      // Listen to auth state changes
      _authService.authStateChanges.listen((User? user) {
        state = state.copyWith(
          user: user,
          isLoading: false,
          isInitialized: true,
        );
      });
      
      // Check current auth status
      final currentUser = _authService.currentUser;
      state = state.copyWith(
        user: currentUser,
        isLoading: false,
        isInitialized: true,
      );
      
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isInitialized: true,
        errorMessage: 'Failed to initialize authentication: $e',
      );
    }
  }

  /// Initialize bridge service with WebView controller
  Future<void> initializeBridge(dynamic controller) async {
    try {
      await _bridgeService.initialize(controller);
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'Failed to initialize auth bridge: $e',
      );
    }
  }

  /// Sign in with email and password
  Future<bool> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      state = state.copyWith(isLoading: true, errorMessage: null);
      
      final result = await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      if (result.success) {
        state = state.copyWith(
          user: result.user,
          isLoading: false,
        );
        return true;
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: result.errorMessage ?? 'Login failed',
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Unexpected error during login: $e',
      );
      return false;
    }
  }

  /// Sign out current user
  Future<bool> signOut() async {
    try {
      state = state.copyWith(isLoading: true, errorMessage: null);
      
      final result = await _authService.signOut();
      
      if (result.success) {
        state = state.copyWith(
          user: null,
          isLoading: false,
        );
        return true;
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: result.errorMessage ?? 'Logout failed',
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Unexpected error during logout: $e',
      );
      return false;
    }
  }

  /// Create user account
  Future<bool> createUserWithEmailAndPassword({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      state = state.copyWith(isLoading: true, errorMessage: null);
      
      final result = await _authService.createUserWithEmailAndPassword(
        email: email,
        password: password,
        displayName: displayName,
      );
      
      if (result.success) {
        state = state.copyWith(
          user: result.user,
          isLoading: false,
        );
        return true;
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: result.errorMessage ?? 'Account creation failed',
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Unexpected error during account creation: $e',
      );
      return false;
    }
  }

  /// Send password reset email
  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      state = state.copyWith(isLoading: true, errorMessage: null);
      
      final result = await _authService.sendPasswordResetEmail(email);
      
      state = state.copyWith(isLoading: false);
      
      if (!result.success) {
        state = state.copyWith(
          errorMessage: result.errorMessage ?? 'Failed to send password reset email',
        );
      }
      
      return result.success;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Unexpected error: $e',
      );
      return false;
    }
  }

  /// Clear error message
  void clearError() {
    state = state.clearError();
  }

  /// Get current authentication status
  Future<AuthStatusResult> getAuthStatus() async {
    return await _authService.getAuthStatus();
  }

  /// Get auth service instance
  AuthService get authService => _authService;

  /// Get bridge service instance
  AuthBridgeService get bridgeService => _bridgeService;
}

/// Authentication state provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

/// Current user provider
final currentUserProvider = Provider<User?>((ref) {
  final authState = ref.watch(authProvider);
  return authState.user;
});

/// Authentication status provider
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authProvider);
  return authState.isAuthenticated;
});

/// Authentication loading state provider
final isAuthLoadingProvider = Provider<bool>((ref) {
  final authState = ref.watch(authProvider);
  return authState.isLoading;
});

/// Authentication error provider
final authErrorProvider = Provider<String?>((ref) {
  final authState = ref.watch(authProvider);
  return authState.errorMessage;
});