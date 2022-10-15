import 'package:hive/hive.dart';
import 'package:the_movie_booking_app/data/vos/payment_vo.dart';

import '../hive_constants.dart';

class PaymentDao{
  static final PaymentDao _singleton=PaymentDao._internal();
  factory PaymentDao(){
    return _singleton;
  }
  PaymentDao._internal();

  void saveAllPayment(List<PaymentVO> paymentList)async{
    Map<int,PaymentVO> paymentMap=Map.fromIterable(paymentList,key: (payment) => payment.id, value: (payment) => payment);
    await getPaymentBox().putAll(paymentMap);
  }

  List<PaymentVO> getAllPayment(){
    return getPaymentBox().values.toList();
  }

  Box<PaymentVO> getPaymentBox(){
    return Hive.box<PaymentVO>(BOX_NAME_PAYMENT_VO);
  }
}