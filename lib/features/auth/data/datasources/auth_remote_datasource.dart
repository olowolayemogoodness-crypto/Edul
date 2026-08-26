import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../core/errors/failures.dart';
import '../models/user_model.dart';
import '../../../../core/services/user_service.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signInWithEmail(String email, String password);
  Future<UserModel> registerWithEmail(String name, String email, String password);
  Future<UserModel> signInWithGoogle();
  Future<void> signOut();
  Future<void> sendPasswordReset(String email);
  Stream<UserModel?> get authStateChanges;
  UserModel? get currentUser;
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthRemoteDataSourceImpl({required FirebaseAuth auth})
    : _auth = auth;

  @override
  Future<UserModel> signInWithEmail(String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
      final user = UserModel.fromFirebase(cred.user!);
      await UserService.ensureProfile(uid: user.uid, displayName: user.displayName, email: user.email);
      return user;
    } on FirebaseAuthException catch (e) { throw AuthFailure(_map(e.code)); }
  }

 

  @override
  Future<UserModel> registerWithEmail(String name, String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await cred.user!.updateDisplayName(name);
      await cred.user!.reload();
      final user = UserModel.fromFirebase(_auth.currentUser!);
      await UserService.ensureProfile(uid: user.uid, displayName: name, email: email);
      return user;
    } on FirebaseAuthException catch (e) { throw AuthFailure(_map(e.code)); }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // User closed the Google account picker without choosing one --
        // not an error, just a cancellation, so a distinct message
        // rather than a generic auth failure.
        throw AuthFailure('Sign-in was cancelled.');
      }
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final cred = await _auth.signInWithCredential(credential);
      final user = UserModel.fromFirebase(cred.user!);
      await UserService.ensureProfile(uid: user.uid, displayName: user.displayName, email: user.email);
      return user;
    } on FirebaseAuthException catch (e) {
      throw AuthFailure(_map(e.code));
    }
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
    // Also sign out of the Google session itself -- otherwise a
    // Google-authenticated user who signs out would get silently
    // re-authenticated with the same account next time, never seeing
    // the account picker again to switch accounts.
    if (await _googleSignIn.isSignedIn()) {
      await _googleSignIn.signOut();
    }
  }

  @override
  Future<void> sendPasswordReset(String email) async {
    try { await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) { throw AuthFailure(_map(e.code)); }
  }

  @override
  Stream<UserModel?> get authStateChanges =>
      _auth.authStateChanges().map((u) => u != null ? UserModel.fromFirebase(u) : null);

  @override
  UserModel? get currentUser =>
      _auth.currentUser != null ? UserModel.fromFirebase(_auth.currentUser!) : null;

  String _map(String code) {
    switch (code) {
      case 'user-not-found': return 'No account found for this email.';
      case 'wrong-password': return 'Incorrect password.';
      case 'email-already-in-use': return 'This email is already registered.';
      case 'weak-password': return 'Password must be at least 6 characters.';
      default: return 'Authentication failed. Please try again.';
    }
  }
}