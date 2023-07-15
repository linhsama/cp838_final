import 'package:cp838_project/consts/consts.dart';

class FirestoreServices {
  static getUser() {
    return firestore
        .collection(userCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getPreviews(id) {
    return firestore
        .collection(previewCollection)
        .where('p_id', isEqualTo: id)
        .snapshots();
  }

  static getAllProducts() {
    return firestore.collection(productCollection).snapshots();
  }

  static getAllCategories() {
    return firestore.collection(categoryCollection).snapshots();
  }

  static getNewProducts() {
    return firestore
        .collection(productCollection)
        .where('is_new', isEqualTo: true)
        .snapshots();
  }

  static getProducts(category) {
    return firestore
        .collection(productCollection)
        .where('p_category', isEqualTo: category)
        .snapshots();
  }

  static getCart(uid) {
    return firestore
        .collection(cartCollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

  static getTotalCart(uid) {
    return firestore
        .collection(cartCollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

  static deleteItem(docId) {
    return firestore.collection(cartCollection).doc(docId).delete();
  }

  static getChatMessages(docId) {
    return firestore
        .collection(chatCollection)
        .doc(docId)
        .collection(messageCollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }

  static getAllOrders() {
    return firestore
        .collection(orderCollection)
        .where('order_by', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getAllWishlists() {
    return firestore
        .collection(productCollection)
        .where('p_wishlist', arrayContains: currentUser!.uid)
        .snapshots();
  }

  static getAllMessages() {
    return firestore
        .collection(chatCollection)
        .where('mess', arrayContains: currentUser!.uid)
        .snapshots();
  }

  static getProductBySearch({required keyword}) {
    return firestore
        .collection(productCollection)
        .where('p_name', isGreaterThanOrEqualTo: keyword.toString())
        .snapshots();
  }
}
