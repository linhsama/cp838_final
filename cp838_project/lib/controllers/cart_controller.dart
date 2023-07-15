import 'package:cp838_project/consts/consts.dart';
import 'package:cp838_project/controllers/home_controller.dart';

class CartController extends GetxController {
  //
  var totalP = 0.obs;
  var paymentIndex = 0.obs;
  var placingOrder = false.obs;

  //
  TextEditingController addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var postalCodeController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var fullnameController = TextEditingController();

  //
  //
  late dynamic productSnapshot;
  var products = [];
  var listshop = [];

  //
  calcTotal(data) {
    totalP.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalP.value += int.parse(data[i]['tprice']);
    }
  }

  placeMyOrder(
      {required orderPaymentMethod,
      required totalAmount,
      required context}) async {
    await getProductDetails();

    await firestore.collection(orderCollection).doc().set({
      'order_code': DateTime.timestamp().microsecond.toString(),
      'order_date': FieldValue.serverTimestamp(),
      'order_by': currentUser!.uid,
      'order_by_name': Get.find<HomeController>().username,
      'order_by_email': currentUser!.email,
      'order_by_address': addressController.text,
      'order_by_fullname': fullnameController.text,
      // 'order_by_state': stateController.text,
      // 'order_by_city': cityController.text,
      'order_by_phoneNumber': phoneNumberController.text,
      // 'order_by_postalCode': postalCodeController.text,
      'shipping_method': 'Home Delivery',
      'payment_method': orderPaymentMethod,
      'order_placed': true,
      'order_confirmed': false,
      // 'order_delivered': false,
      // 'order_on_delivery': false,
      'total_amount': totalAmount,
      'orders': FieldValue.arrayUnion(products),
      'shop_id': listshop
    });
  }

  getProductDetails() {
    products.clear();
    listshop.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      listshop.add(productSnapshot[i]['shop_id']);
      products.add({
        'color': productSnapshot[i]['color'],
        'img': productSnapshot[i]['img'],
        'qty': productSnapshot[i]['qty'],
        'shop_id': productSnapshot[i]['shop_id'],
        'tprice': productSnapshot[i]['tprice'],
        'title': productSnapshot[i]['title'],
      });
    }
  }

  clearCard(context) {
    for (var i = 0; i < productSnapshot.length; i++) {
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
    VxToast.show(context, msg: 'Order placed successfully');
  }
}
