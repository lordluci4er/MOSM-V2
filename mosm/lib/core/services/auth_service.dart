import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  /// 🔒 Singleton
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// 👤 Current user
  User? get currentUser => _auth.currentUser;

  /// 🔁 Login status
  bool get isLoggedIn => _auth.currentUser != null;

  /// 🔄 Auth state stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // =====================================================
  // 🔐 GOOGLE SIGN-IN (FIXED VERSION 💀)
  // =====================================================
  Future<User?> signInWithGoogle() async {
    try {
      /// 🔥 FORCE ACCOUNT PICKER (IMPORTANT FIX)
      await _googleSignIn.signOut();

      final googleUser = await _googleSignIn.signIn();

      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await _auth.signInWithCredential(credential);

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw Exception("Firebase Auth Error: ${e.message}");
    } catch (e) {
      throw Exception("Google Sign-In failed: $e");
    }
  }

  // =====================================================
  // 🔑 TOKEN (CLEAN VERSION)
  // =====================================================
  Future<String> getToken({bool forceRefresh = true}) async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        throw Exception("User not logged in");
      }

      final token = await user.getIdToken(forceRefresh);

      if (token == null || token.isEmpty) {
        throw Exception("Invalid token received");
      }

      return token;
    } catch (e) {
      throw Exception("Token fetch failed: $e");
    }
  }

  // =====================================================
  // 🚪 LOGOUT
  // =====================================================
  Future<void> logout() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      throw Exception("Logout failed: $e");
    }
  }
}