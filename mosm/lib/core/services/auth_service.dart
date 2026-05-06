import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  /// 🔒 Singleton (important for consistency)
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// 👤 Current user (getter)
  User? get currentUser => _auth.currentUser;

  /// 👤 Safe method version
  User? getCurrentUser() => _auth.currentUser;

  /// 🔐 Google Sign-In
  Future<User?> signInWithGoogle() async {
    try {
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

  /// 🔑 Get Firebase ID Token (backend use)
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

  /// 🔁 Check login status
  bool get isLoggedIn => _auth.currentUser != null;

  /// 🔄 Listen auth changes (optional powerful)
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// 🚪 Logout
  Future<void> logout() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      throw Exception("Logout failed: $e");
    }
  }
}