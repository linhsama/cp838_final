import 'dart:math';

import 'package:cp838_project/consts/consts.dart';

class HomeController extends GetxController {
  var currentNavIndex = 0.obs;
  var username = '';
  var searchController = TextEditingController();
  var shopname = '';
  var photoUrl = '';
  @override
  void onInit() {
    super.onInit();
    getUsername();
  }

  getUsername() async {
    await firestore
        .collection(userCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then(
      (value) {
        if (value.docs.isNotEmpty) {
          username = value.docs[0]['username'];
          photoUrl = value.docs[0]['imageUrl'];
        }
      },
    );
    // print(username);
  }

  addProductRandom() async {
    var data = {
      'p_category': 'Computer & Accessories',
      'p_category_sub': 'Laptop',
      'p_colors': {
        '4294198070',
        '4283215696',
        '4288855856',
      },
      'p_count_rating': '5',
      'p_desc': 'This is a descrition for product...',
      'p_imgs': {
        'https://firebasestorage.googleapis.com/v0/b/cp838-project.appspot.com/o/images%2Fproducts%2Fp1.jpeg?alt=media&token=4247e446-65e6-48dc-b43e-2cecf9b94593',
        'https://firebasestorage.googleapis.com/v0/b/cp838-project.appspot.com/o/images%2Fproducts%2Fp2.jpeg?alt=media&token=611c739b-3154-4eda-a25b-5c7c89f59c5b',
        'https://firebasestorage.googleapis.com/v0/b/cp838-project.appspot.com/o/images%2Fproducts%2Fp3.jpeg?alt=media&token=98307a19-4966-4c5b-b234-9f70118e4a05',
      },
      'p_name': 'Laptop${DateTime.now()}',
      'p_price': '29999000',
      'p_quantity': '200',
      'p_rating': '4.0',
      'p_shopname': 'Admin',
      'is_feature': true,
      'p_wishlist': {},
      'shop_id': 'ilq4Pj8F3uOGFGErDIkhkPk997N2',
    };

    // DocumentReference copyFrom =
    //     firestore.collection('products2').doc('MiZ1rVEoJUUpNhZCXA5w');
    // DocumentReference copyTo = firestore.collection('products').doc();
    // copyFrom.get().then((value) => {copyTo.set(value.data())});
    firestore.collection('products').doc().set(data);
  }
}
