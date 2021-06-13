import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class MitmitFirebaseUser {
  MitmitFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

MitmitFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<MitmitFirebaseUser> mitmitFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<MitmitFirebaseUser>((user) => currentUser = MitmitFirebaseUser(user));
