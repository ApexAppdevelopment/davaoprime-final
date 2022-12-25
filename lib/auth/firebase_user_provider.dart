import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class DavaoprimeappFirebaseUser {
  DavaoprimeappFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

DavaoprimeappFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<DavaoprimeappFirebaseUser> davaoprimeappFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<DavaoprimeappFirebaseUser>(
      (user) {
        currentUser = DavaoprimeappFirebaseUser(user);
        return currentUser!;
      },
    );
