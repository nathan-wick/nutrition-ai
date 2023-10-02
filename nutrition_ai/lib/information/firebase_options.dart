import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCd_uTC3pfrefXQ3fKi0h6xjUeiMtketxE',
    appId: '1:552519649799:web:153b1494be2d99ff5b38a2',
    messagingSenderId: '552519649799',
    projectId: 'nathan-wick-nutrition-ai',
    authDomain: 'nathan-wick-nutrition-ai.firebaseapp.com',
    storageBucket: 'nathan-wick-nutrition-ai.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC8qyANadHz_U-rU-lyaU_FoQFrGJkvYV4',
    appId: '1:552519649799:android:2507ef049a1caeb55b38a2',
    messagingSenderId: '552519649799',
    projectId: 'nathan-wick-nutrition-ai',
    storageBucket: 'nathan-wick-nutrition-ai.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCLzGRd3IG1_daAF543AQYrra5WfhNq5Jk',
    appId: '1:552519649799:ios:b16a5014d29cccfe5b38a2',
    messagingSenderId: '552519649799',
    projectId: 'nathan-wick-nutrition-ai',
    storageBucket: 'nathan-wick-nutrition-ai.appspot.com',
    iosClientId: '552519649799-dqjo4nu82bc4o79b0qstssoa320dcjn5.apps.googleusercontent.com',
    iosBundleId: 'com.example.nutritionAi',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCLzGRd3IG1_daAF543AQYrra5WfhNq5Jk',
    appId: '1:552519649799:ios:b16a5014d29cccfe5b38a2',
    messagingSenderId: '552519649799',
    projectId: 'nathan-wick-nutrition-ai',
    storageBucket: 'nathan-wick-nutrition-ai.appspot.com',
    iosClientId: '552519649799-dqjo4nu82bc4o79b0qstssoa320dcjn5.apps.googleusercontent.com',
    iosBundleId: 'com.example.nutritionAi',
  );
}
