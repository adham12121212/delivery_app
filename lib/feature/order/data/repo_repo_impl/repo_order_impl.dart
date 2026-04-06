import 'package:delivery_app/feature/order/domain/repo_order/repo_order.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/erorr/api_exception.dart';
import '../../../../core/erorr/firebase_auth_error_mapper.dart';
import '../../../../core/service/firestore_data.dart';
import '../model/order_model.dart';

class RepoOrderImpl implements RepoOrder{

  final FireStoreData fireStoreData;
  RepoOrderImpl( this.fireStoreData);
  @override
  Future<List<OrderModel>> getOrder(String userId) async{
    try{
     final data = await fireStoreData.getOrder(userId);
     return data;
    }on FirebaseAuthException catch (e) {
      throw FirebaseAuthErrorMapper.map(e);
    } on ApiException {
      rethrow;
    } catch (_) {
      throw ApiException('حدث خطأ غير متوقع');
    }
  }

  @override
  @override
  Future<void> addOrder(String userId, OrderModel order) async {
    try{
      await fireStoreData.addOrder(userId, order);

    }on FirebaseAuthException catch (e) {
      throw FirebaseAuthErrorMapper.map(e);
    } on ApiException {
      rethrow;
    } catch (_) {
      throw ApiException('حدث خطأ غير متوقع');
    }
  }


}