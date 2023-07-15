import 'dart:io';

import 'package:cp838_seller_project/consts/consts.dart';
import 'package:cp838_seller_project/controllers/home_controller.dart';
import 'package:cp838_seller_project/models/category_model.dart';
import 'package:cp838_seller_project/views/home_screen/home.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProductController extends GetxController {
  var pnameController = TextEditingController();
  var cnameController = TextEditingController();
  var cdescController = TextEditingController();
  var pdescController = TextEditingController();
  var ppriceController = TextEditingController();
  var pquantityController = TextEditingController();
  var ratingController = TextEditingController();
  var ppreviewController = TextEditingController();

  var categoryList = <String>[].obs;
  var subcategoryList = <String>[].obs;
  List<Category> category = [];
  var pPreviewImagesList = RxList<dynamic>.generate(3, (index) => null);

  var pImagesList = RxList<dynamic>.generate(3, (index) => null);
  var pColorsList = RxList<dynamic>.generate(3, (index) => null);
  var categoryValue = ''.obs;
  var isNew = true.obs;
  var pImagesLink = [];
  var pImagesPreviewLink = [];
  var ratingCount = (5.0).obs;

  var subcategoryValue = ''.obs;
  var selectedColorIndex = 0.obs;

  var subCat = [];
  var quantity = 1.obs;
  var colorIndex = 0.obs;
  var total = 0.0.obs;
  var isFav = false.obs;
  var isLoading = false.obs;

  var countWishlist = 0.obs;
  var countCategory = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getCategories();
  }

  clearList() {
    pColorsList = RxList<dynamic>.generate(3, (index) => null);
    pImagesList = RxList<dynamic>.generate(3, (index) => null);
    pPreviewImagesList = RxList<dynamic>.generate(3, (index) => null);
    pImagesPreviewLink.clear();
    isLoading = false.obs;
    pnameController.clear();
    ppriceController.clear();
    pquantityController.clear();
    pdescController.clear();
    cnameController.clear();
    cdescController.clear();
    pImagesLink.clear();
  }

  listImages(list) {
    var res = [];
    list.forEach(
      (item) {
        if (item != null) res.add(item);
      },
    );
    return res.length;
  }

  getCategories() async {
    var data = await rootBundle.loadString('lib/services/category_model.json');
    var decode = categoryModelFromJson(data);
    category = decode.categories;
  }

  populateCategoryList() {
    categoryList.clear();
    for (var item in category) {
      categoryList.add(item.categoryName);
    }
  }

  populateSubCategoryList(title) {
    var data =
        category.where((element) => element.categoryName == title).toList();

    for (var i = 0; i < data.first.caterorySub.length; i++) {
      subcategoryList.add(data.first.caterorySub[i]);
    }
  }

  getSubCategories(title) async {
    subCat.clear();
    var data = await rootBundle.loadString('lib/services/category_model.json');
    var decode = categoryModelFromJson(data);
    var result = decode.categories
        .where((element) => element.categoryName == title)
        .toList();

    for (var item in result[0].caterorySub) {
      subCat.add(item);
    }
  }

  // addToCart(
  //     {required title,
  //     required img,
  //     required sellername,
  //     required color,
  //     required qty,
  //     required tprice,
  //     required shopId,
  //     required context}) {
  //   firestore
  //       .collection(cartCollection)
  //       .where('added_by', isEqualTo: currentUser!.uid)
  //       .where('color', isEqualTo: color)
  //       .get()
  //       .then((value) async {
  //     if (value.docs.isNotEmpty) {
  //       await firestore.collection(cartCollection).doc(value.docs[0].id).set({
  //         'title': title,
  //         'img': img,
  //         'sellername': sellername,
  //         'color': color,
  //         'qty': qty,
  //         'shop_id': shopId,
  //         'tprice': tprice,
  //         'added_by': currentUser!.uid
  //       }).catchError((error) {
  //         VxToast.show(context, msg: error.toString());
  //       });
  //     } else {
  //       await firestore.collection(cartCollection).doc().set({
  //         'title': title,
  //         'img': img,
  //         'sellername': sellername,
  //         'color': color,
  //         'qty': qty,
  //         'tprice': tprice,
  //         'shop_id': shopId,
  //         'added_by': currentUser!.uid
  //       }).catchError((error) {
  //         VxToast.show(context, msg: error.toString());
  //       });
  //     }
  //   });
  // }

  addWishList(docId, context) async {
    await firestore.collection(productCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(true);
    VxToast.show(context, msg: 'Added to wishlish');
  }

  removeWishList(docId, context) async {
    await firestore.collection(productCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(false);
    VxToast.show(context, msg: 'Removed from wishlish');
  }

  getThisWishlists(docId, pName) async {
    return await firestore
        .collection(productCollection)
        .where('p_name', isEqualTo: pName)
        .where('p_wishlist', arrayContains: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        isFav(false);
      } else {
        isFav(true);
      }
    });
  }

  getCountCaterory(pCategory) async {
    return await firestore
        .collection(productCollection)
        .where('p_category', isEqualTo: pCategory)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        countCategory(0);
      } else {
        countCategory(value.docs.length);
      }
    });
  }

  getAllWishlists(pName) async {
    return await firestore
        .collection(productCollection)
        .where('p_name', isEqualTo: pName)
        .where('p_wishlist', isNotEqualTo: null)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        countWishlist(0);
      } else {
        return countWishlist(value.docs.length);
      }
    });
  }

  getColors(data) {
    var pColors = [];
    for (var i = 0; i < data.length; i++) {
      if (data[i] != null) {
        pColors.add(i);
      }
    }
    return pColors;
  }

  getImgs(data) {
    var pImgs = [];
    for (var i = 0; i < data.length; i++) {
      if (data[i] != null) {
        pImgs.add(i);
      }
    }
    return pImgs;
  }

  getList(data) {
    for (var i = 0; i < data.length; i++) {
      if (data[i] == null) {
        colorList.removeAt(i);
      }
    }
  }

  pickImage(index, context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (img == null) {
        return;
      }
      pImagesList[index] = File(img.path);
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadImage({required context}) async {
    isLoading(true);
    pImagesLink.clear();

    for (var item in pImagesList) {
      var filename = basename(item.path) + DateTime.now().toString();
      var destination = 'images/shops/${currentUser!.uid}/products/$filename';

      Reference reference = FirebaseStorage.instance.ref().child(destination);
      await reference.putFile(item);
      var res = await reference.getDownloadURL();
      pImagesLink.add(res);
      VxToast.show(context, msg: 'Image passed ${pImagesLink.length}');
    }
  }

  addProduct({required context}) async {
    var store = firestore.collection(productCollection).doc();
    await store.set({
      'is_new': isNew.value,
      'is_feature': false,
      'p_category': categoryValue.value,
      'p_colors': FieldValue.arrayUnion(
          pColorsList.isNotEmpty ? (pColorsList) : ["4280391411"]),
      'p_imgs': FieldValue.arrayUnion(pImagesLink.isNotEmpty
          ? pImagesLink
          : [
              "https://firebasestorage.googleapis.coưm/v0/b/cp838-project.appspot.com/o/images%2Fusers%2Fcat.png?alt=media&token=3f29a138-4963-44cf-bab8-a697c591a5d5"
            ]),
      'p_wishlist': FieldValue.arrayUnion([]),
      'p_desc': pdescController.text,
      'p_name': pnameController.text,
      'p_price': ppriceController.text,
      'p_quantity': pquantityController.text,
      'p_shopname': Get.find<HomeController>().shopname,
      'p_rating': '5.0',
      'shop_id': currentUser!.uid,
      'feature_id': '',
    }).then((value) {
      isLoading(false);

      pnameController.clear();
      ppriceController.clear();
      pquantityController.clear();
      pdescController.clear();
      pImagesLink.clear();
      pImagesList = RxList<dynamic>.generate(3, (index) => null);
      pColorsList = RxList<dynamic>.generate(3, (index) => null);

      VxToast.show(context, msg: 'Product Updated');
    }).onError((error, stackTrace) {
      VxToast.show(context, msg: 'Product Updated Failed');
    });
  }

  updateProduct({required id, required context}) async {
    var store = firestore.collection(productCollection).doc(id);
    await store.update({
      'is_new': isNew.value,
      'is_feature': false,
      'p_category': categoryValue.value,
      // 'p_colors': FieldValue.arrayUnion(
      //     pColorsList.isNotEmpty ? (pColorsList) : ["4280391411"]),
      // 'p_imgs': FieldValue.arrayUnion(pImagesLink.isNotEmpty
      //     ? pImagesLink
      //     : [
      //         "https://firebasestorage.googleapis.com/v0/b/cp838-project.appspot.com/o/images%2Fusers%2Fcat.png?alt=media&token=3f29a138-4963-44cf-bab8-a697c591a5d5"
      //       ]),
      'p_wishlist': FieldValue.arrayUnion([]),
      'p_desc': pdescController.text,
      'p_name': pnameController.text,
      'p_price': ppriceController.text,
      'p_quantity': pquantityController.text,
      'p_shopname': Get.find<HomeController>().shopname,
      'p_rating': '5.0',
      'shop_id': currentUser!.uid,
      'feature_id': '',
    }).then((value) {
      isLoading(false);

      pnameController.clear();
      ppriceController.clear();
      pquantityController.clear();
      pdescController.clear();
      pImagesLink.clear();
      pImagesList = RxList<dynamic>.generate(3, (index) => null);
      pColorsList = RxList<dynamic>.generate(3, (index) => null);

      VxToast.show(context, msg: 'Product Updated');
    }).onError((error, stackTrace) {
      VxToast.show(context, msg: 'Product Updated Failed');
    });
  }

  deleteProduct({required docId, required context}) async {
    var store = firestore.collection(productCollection).doc(docId);
    await store.delete().then((value) {
      isLoading(false);

      VxToast.show(context, msg: 'Product Updated');
    }).onError((error, stackTrace) {
      VxToast.show(context, msg: 'Product Updated Failed');
    });
  }

  pickImagePreview(index, context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (img == null) {
        return;
      }
      pPreviewImagesList[index] = File(img.path);
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadImagePreview(context) async {
    pImagesPreviewLink.clear();

    for (var item in pPreviewImagesList) {
      var filename = basename(item.path) + DateTime.now().toString();
      var destination = 'images/shops/${currentUser!.uid}/previews/$filename';
      Reference reference = FirebaseStorage.instance.ref().child(destination);
      await reference.putFile(item);
      var res = await reference.getDownloadURL();
      pImagesPreviewLink.add(res);
      VxToast.show(context, msg: 'Image passed ${pImagesPreviewLink.length}');
    }
    return pImagesPreviewLink;
  }

  updatePreview(data, context) async {
    isLoading(true);
    var store = firestore.collection(previewCollection).doc();
    await store.set({
      'p_id': data.id,
      'p_name': data['p_name'],
      'p_photoUrl': Get.find<HomeController>().photoUrl.isNotEmpty
          ? Get.find<HomeController>().photoUrl
          : "https://firebasestorage.googleapis.com/v0/b/cp838-project.appspot.com/o/images%2Fusers%2Fcat.png?alt=media&token=3f29a138-4963-44cf-bab8-a697c591a5d5",
      'p_user_id': currentUser!.uid,
      'p_username': Get.find<HomeController>().username,
      'p_shop_id': data['shop_id'],
      'p_rating': ratingCount.value,
      'p_preview': ppreviewController.text,
      'created_on': FieldValue.serverTimestamp(),
      'p_imgs': FieldValue.arrayUnion(pImagesPreviewLink.isNotEmpty
          ? pImagesPreviewLink
          : [
              // "https://firebasestorage.googleapis.com/v0/b/cp838-project.appspot.com/o/images%2Fusers%2Fcat.png?alt=media&token=3f29a138-4963-44cf-bab8-a697c591a5d5"
            ]),
    }).then((value) {
      isLoading(false);

      ratingCount(5.0);
      pPreviewImagesList = RxList<dynamic>.generate(3, (index) => null);
      pImagesPreviewLink.clear();
      ppreviewController.clear();

      VxToast.show(context, msg: 'Added to preview');
    }).onError((error, stackTrace) {
      VxToast.show(context, msg: '$error Added to preview failed');
    });
  }

  addCategory({required context}) async {
    var store = firestore.collection(categoryCollection).doc();
    try {
      await store.set({
        'shop_id': currentUser!.uid,
        'shop_name': Get.put(HomeController()).shopname,
        'c_name': cnameController.text,
        'c_imgs': FieldValue.arrayUnion(pImagesLink.isNotEmpty
            ? pImagesLink
            : [
                "https://firebasestorage.googleapis.com/v0/b/cp838-project.appspot.com/o/images%2Fusers%2Fcat.png?alt=media&token=3f29a138-4963-44cf-bab8-a697c591a5d5"
              ]),
        'c_desc': cdescController.text,
      }).then((value) {
        isLoading(false);

        cnameController.clear();
        cdescController.clear();
        pImagesLink.clear();
        pImagesList = RxList<dynamic>.generate(1, (index) => null);

        VxToast.show(context, msg: 'Category Updated');
      }).onError((error, stackTrace) {
        VxToast.show(context, msg: 'Category Updated Failed');
      });
    } catch (e) {
      VxToast.show(context, msg: 'Category Updated Failed $e');
    }
  }
}
