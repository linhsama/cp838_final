import 'package:cp838_seller_project/consts/consts.dart';

class OrdersController extends GetxController {
  var orders = [];
  var confirmed = false.obs;
  var ondelivery = false.obs;
  var delivered = false.obs;

  getOrders(data) {
    orders.clear();
    for (var item in data['orders']) {
      if (item['shop_id'] == currentUser!.uid) {
        orders.add(item);
      }
    }
  }

  changeStatus({required title, required status, required docID}) async {
    var store = firestore.collection(orderCollection).doc(docID);
    await store.set({title: status}, SetOptions(merge: true));
  }
}
