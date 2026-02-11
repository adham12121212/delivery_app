import 'package:firebase_auth/firebase_auth.dart';

import 'api_exception.dart';

class FirebaseAuthErrorMapper {
  static ApiException map(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return ApiException('الحساب غير موجود');
      case 'wrong-password':
        return ApiException('كلمة المرور غير صحيحة');
      case 'invalid-credential':
      case 'invalid-login-credentials':
        return ApiException('البريد الإلكتروني أو كلمة المرور غير صحيحة');

      case 'email-already-in-use':
        return ApiException('البريد مستخدم بالفعل');
      case 'invalid-email':
        return ApiException('بريد غير صالح');
      case 'weak-password':
        return ApiException('كلمة المرور ضعيفة');
      case 'network-request-failed':
        return ApiException('تحقق من اتصال الإنترنت');
      default:
        return ApiException('حدث خطأ غير متوقع');
    }
  }
}
