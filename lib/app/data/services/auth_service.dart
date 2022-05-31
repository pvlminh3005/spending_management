import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../core/utilities/app_utils.dart';
import '../../core/utilities/utilities.dart';
import '../../routes/app_pages.dart';

class AuthService extends GetxService {
  final _isAuth = false.obs;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  late String _verificationId;

  bool get isAuth => _isAuth.value;

  Future<AuthService> init() async {
    _isAuth(_firebaseAuth.currentUser != null);
    return this;
  }

  void signInWithPhoneNumber(
    String yourPhone, {
    Function(PhoneAuthCredential)? onCompleted,
    Function(String, int?)? onSuccess,
    Function(FirebaseAuthException)? onFailed,
    Function(String)? onTimeout,
    int timeOut = 1,
  }) {
    _firebaseAuth.verifyPhoneNumber(
      phoneNumber: yourPhone,
      verificationCompleted: (PhoneAuthCredential credential) {
        onCompleted?.call(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        onFailed?.call(e);
      },
      codeSent: (String verificationId, int? resendToken) {
        verificationId = verificationId;
        onSuccess?.call(verificationId, resendToken);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
        onTimeout?.call(verificationId);
      },
      timeout: Duration(seconds: timeOut),
    );
  }

  Future<void> verifyOTP({
    required String smsCode,
    required Function(UserCredential) onSuccess,
    required Function(dynamic) onError,
  }) async {
    try {
      var credentials = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: smsCode,
      );

      await _firebaseAuth.signInWithCredential(credentials).then(
        (UserCredential user) {
          _isAuth(true);
          onSuccess.call(user);
        },
      );
    } on FirebaseAuthException catch (e) {
      onError.call(e.message!);
      AppUtils.toast(StringUtils.verifyOtpError);
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      Get.offAndToNamed(Routes.login);
    } on FirebaseAuthException catch (e) {
      AppUtils.toast(e.message!);
    }
  }
}
