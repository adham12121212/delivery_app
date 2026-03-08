
import 'package:delivery_app/feature/Auth/domain/entity/user_entity.dart';

import '../../data/model/user_model.dart';

abstract class AuthRepo {
  Future<UserEntity> signInWithEmailAndPassword({required String email,required String password});
  Future<UserEntity> signUpWithEmailAndPassword({required String email, required String password,required String name});
  Future<UserEntity> signInWithGoogle();
  Future<UserEntity> signInWithFacebook();
  Future<UserEntity> addUserData(UserModel userModel);}