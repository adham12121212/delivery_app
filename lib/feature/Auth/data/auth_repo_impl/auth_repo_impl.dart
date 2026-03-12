import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/feature/Auth/domain/entity/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/erorr/api_exception.dart';
import '../../../../core/erorr/firebase_auth_error_mapper.dart';
import '../../../../core/service/firebase_service.dart';
import '../../../../core/service/firestore_data.dart';
import '../../domain/auth_repo/auth_repo.dart';
import '../model/user_model.dart';

class AuthRepoImpl implements AuthRepo{
  final FireBaseService fireBaseService;
  final FireStoreData fireStoreData;
  AuthRepoImpl({required this.fireBaseService,required this.fireStoreData});

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
      final user = await fireBaseService.signUpWithEmailAndPassword(
        email: email,
        password: password,
      );

      final userModel = UserModel(
        id: user.uid,
        email: user.email ?? '',
        name: name,
      );

      await addUserData(userModel);

      return userModel;
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
      final userModel = UserModel.fromFirebase(data);

      final doc = await FirebaseFirestore.instance
          .collection('user')
          .doc(userModel.id)
          .get();

      if(!doc.exists){
        await addUserData(userModel);
      }
      return userModel;
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
      final userModel = UserModel.fromFirebase(data);
      final doc = await FirebaseFirestore.instance
          .collection('user')
          .doc(userModel.id)
          .get();

      if(!doc.exists){
        await addUserData(userModel);
      }
      return userModel;
    }on FirebaseAuthException catch (e){
      print('FirebaseAuthException${e}');
      throw FirebaseAuthErrorMapper.map(e);
    } catch(e){
      print('catch${e}');
      throw ApiException('حدث خطأ غير متوقع');
    }
  }

  @override
  Future<UserEntity> addUserData(UserModel userModel) async {
    try {

      await fireStoreData.addData(
        path: 'user',
        documentId: userModel.id,
        data: userModel.toMap(),
      );

      return userModel;

    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthErrorMapper.map(e);
    } catch (_) {
      throw ApiException('حدث خطأ غير متوقع');
    }
  }





}