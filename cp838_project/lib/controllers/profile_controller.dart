import 'dart:io';

import 'package:cp838_project/consts/consts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  //
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var oldPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var profileImgPath = ''.obs;
  var profileImageLink = '';
  var isLoading = false.obs;
  bool isShop = false;
  var countWishlist;
  var countCart;
  var countOrder;
  var countMessage;

  @override
  void onInit() {
    super.onInit();
    checkUser();
    getCarts();
    getOrders();
    getWishlists();
  }

  checkUser() {
    firestore
        .collection(userCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        isShop = true;
      } else {
        isShop = false;
      }
    });
  }

  changeImage({required context}) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (img == null) {
        return;
      }
      profileImgPath.value = img.path;
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadProfileImage() async {
    var fileName = basename(profileImgPath.value);
    var destination = 'image/${currentUser!.uid}/$fileName';
    Reference reference = FirebaseStorage.instance.ref().child(destination);
    await reference.putFile(File(profileImgPath.value));
    profileImageLink = await reference.getDownloadURL();
  }

  updateProfile(
      {required username, required password, required imageUrl}) async {
    var storge = firestore.collection(userCollection).doc(currentUser!.uid);
    await storge.set(
        {'username': username, 'password': password, 'imageUrl': imageUrl},
        SetOptions(merge: true));
    isLoading(false);
  }

  changeAuthPassword(
      {required email, required password, required newPassword}) async {
    final cred = EmailAuthProvider.credential(email: email, password: password);
    await currentUser!.reauthenticateWithCredential(cred).then((value) {
      currentUser!.updatePassword(newPassword);
    }).catchError((error) {
      printError(info: error.toString());
    });
  }

  getWishlists() {
    firestore
        .collection(productCollection)
        .where('p_wishlist', arrayContains: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        countWishlist = value.docs.count();
      } else {
        countWishlist = 0;
      }
    });
    return countWishlist;
  }

  getCarts() {
    firestore
        .collection(cartCollection)
        .where('added_by', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        countCart = value.docs.count();
      } else {
        countCart = 0;
      }
    });
    return countCart;
  }

  getMessages() {
    firestore
        .collection(messageCollection)
        .where('fromId', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        countMessage = value.docs.count();
      } else {
        countMessage = 0;
      }
    });
    return countMessage;
  }

  getOrders() {
    firestore
        .collection(orderCollection)
        .where('order_by', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        countOrder = value.docs.count();
      } else {
        countOrder = 0;
      }
    });
    return countOrder;
  }
}
