
import 'package:delivery_app/feature/Auth/domain/entity/user_entity.dart';

abstract class AuthRepo {
  Future<UserEntity> signInWithEmailAndPassword({required String email,required String password});
} 