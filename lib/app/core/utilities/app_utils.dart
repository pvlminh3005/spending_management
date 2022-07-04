import 'dart:developer' as developer;
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../styles/style.dart';

class AppUtils {
  AppUtils._();

  static void log(dynamic msg, {String? tag}) {
    if (kDebugMode) {
      developer.log(msg.toString(), name: tag ?? 'Spending Management');
    }
  }

  static void toast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: const Color(0xFF1E1E1E).withOpacity(0.95),
      textColor: Colors.white,
      fontSize: 14.sp,
    );
  }

  static void internetLookUp() async {
    try {
      await InternetAddress.lookup('google.com').catchError((e) {
        toast('No internet connection ${e.toString()}');
      });
    } catch (err) {
      toast('No internet connection. ${err.toString()}');
    }
  }
}
