import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDovZtd-e-VjfJTjZ89mDtniRVFl8yQrS4",
            authDomain: "socializer22.firebaseapp.com",
            projectId: "socializer22",
            storageBucket: "socializer22.appspot.com",
            messagingSenderId: "752722598134",
            appId: "1:752722598134:web:fc88f970495e580a2e34d7",
            measurementId: "G-CHLHKQRMEG"));
  } else {
    await Firebase.initializeApp();
  }
}
