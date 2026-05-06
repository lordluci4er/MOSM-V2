import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// 🔹 Current logged-in user (getter)
  User? get currentUser => _auth.currentUser;

  /// 🔹 Alternate method (for clean architecture usage)
  User? getCurrentUser() {
    return _auth.currentUser;
  }

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
    } catch (e) {
      throw Exception("Google Sign-In failed: $e");
    }
  }

  /// 🔑 Get Firebase ID Token (Backend API ke liye)
  Future<String> getToken() async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception("User not logged in");
    }

    /// 🔥 Force refresh token (recommended)
    final token = await user.getIdToken(true);

    if (token == null || token.isEmpty) {
      throw Exception("Failed to get valid token");
    }

    return token;
  }

  /// 🚪 Logout (Google + Firebase)
  Future<void> logout() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}