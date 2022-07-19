import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions? get currentPlatform {
    if (Platform.isIOS) {
      return const FirebaseOptions(
        apiKey: 'AIzaSyDie3oh4a92GvIVfNcTuPGuIdWBjFAmqcc',
        appId: '1:976328238826:ios:f0bb9ae62eba52b1f59993',
        messagingSenderId: '976328238826',
        projectId: 'savingmanagement-58012',
      );
    } else if (Platform.isAndroid) {
      return const FirebaseOptions(
        apiKey: 'AIzaSyB4HiMqHGDcaMZe81mh3XYL_SZafhb_Noo',
        appId: '1:976328238826:android:528995016433ae2ef59993',
        messagingSenderId: '976328238826',
        projectId: 'savingmanagement-58012',
      );
    }
    return null;
  }

  static String? get appName {
    if (Platform.isAndroid) return 'Spending Management';
    return null;
  }
}
