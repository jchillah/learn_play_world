/* 
  X Zugriff auf User (UID, Email, DisplayName, PhotoURL)
  X Registierung
  X Login
  X Logout
  X AuthStateChanges
  
   */

import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  // Attribute
  final FirebaseAuth _firebaseAuth;

  // Konstruktor
  AuthRepository(this._firebaseAuth, {required options});

  // Methoden

  /// returns the currently logged in [User]
  /// or `null` if no User is logged in
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  Future<void> signUpWithEmailAndPassword(String email, String pw) {
    return _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: pw,
    );
  }

  Future<void> loginWithEmailAndPassword(String email, String pw) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: pw,
    );
  }

  Future<void> signInAnonymously() {
    return _firebaseAuth.signInAnonymously();
  }

  Future<void> logout() {
    return _firebaseAuth.signOut();
  }

  Stream<User?> authStateChanges() {
    return _firebaseAuth.authStateChanges();
  }

  Future<void> sendPasswordResetEmail(String email) {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  // Benutzerprofil aktualisieren
  Future<void> updateProfile({String? displayName, String? photoURL}) async {
    User? user = _firebaseAuth.currentUser;

    if (user != null) {
      await user.updateProfile(displayName: displayName, photoURL: photoURL);
      await user.reload();
    }
  }
}








