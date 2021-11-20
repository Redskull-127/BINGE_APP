import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-5854213705609546/6432866274';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }
}
