import 'package:delivery_app/feature/Auth/domain/entity/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/erorr/api_exception.dart';
import '../../../../core/erorr/firebase_auth_error_mapper.dart';
import '../../../../core/service/firebase_service.dart';
import '../../domain/auth_repo/auth_repo.dart';
import '../model/user_model.dart';

class AuthRepoImpl implements AuthRepo{
  final FireBaseService fireBaseService;
  AuthRepoImpl({required this.fireBaseService});

  @override
  Future<UserEntity> signInWithEmailAndPassword({required String email, required String password}) async{
   try{
     final data = await fireBaseService.signInWithEmailAndPassword(email: email, password: password);
     return UserModel.fromFirebase(data);
   }on FirebaseAuthException catch (e) {
     throw FirebaseAuthErrorMapper.map(e);
   } on ApiException {
     rethrow;
   } catch (_) {
     throw ApiException('حدث خطأ غير متوقع');
   }
  }

  @override
  Future<UserEntity> signUpWithEmailAndPassword({required String email, required String password ,required String name}) async{
    try{
      final data = await fireBaseService.signUpWithEmailAndPassword(
          email: email,
          password: password,
      );
      return UserModel.fromFirebase(data);
    }on FirebaseAuthException catch (e){
      throw FirebaseAuthErrorMapper.map(e);
    } catch(e){
      throw ApiException('حدث خطأ غير متوقع');
    }
  }

  @override
  Future<UserEntity> signInWithGoogle() async{
    try{
      final data = await fireBaseService.signInWithGoogle();
      return UserModel.fromFirebase(data);
    }on FirebaseAuthException catch (e){
      print('FirebaseAuthException${e}');
      throw FirebaseAuthErrorMapper.map(e);
    } catch(e){
      print('catch${e}');
      throw ApiException('حدث خطأ غير متوقع');
    }
  }

  @override
  Future<UserEntity> signInWithFacebook() async{
    try{
      final data = await fireBaseService.signInWithFacebook();
      return UserModel.fromFirebase(data);
    }on FirebaseAuthException catch (e){
      print('FirebaseAuthException${e}');
      throw FirebaseAuthErrorMapper.map(e);
    } catch(e){
      print('catch${e}');
      throw ApiException('حدث خطأ غير متوقع');
    }
  }





}