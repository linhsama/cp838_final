// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:cp838_seller_project/consts/consts.dart';
import 'package:cp838_seller_project/controllers/home_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ChatController extends GetxController {
  var isLoading = false.obs;
  var chats = firestore.collection(chatCollection);
  var toId = Get.arguments[0];
  var toName = Get.arguments[1];
  var fromId = currentUser!.uid;
  var fromName = Get.find<HomeController>().username;

  var msgController = TextEditingController();
  var pImagesList;
  var pImagesLink;
  var chatDocId;

  pickImage(context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (img == null) {
        return;
      }
      pImagesList = File(img.path);
      // VxToast.show(context, msg: 'Image passed $pImagesList');
      await uploadImage(context: context);
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadImage({required context}) async {
    isLoading(true);
    pImagesLink = '';

    var filename = basename(pImagesList.path) + DateTime.now().toString();
    var destination = 'images/shops/${currentUser!.uid}/chats/$filename';

    Reference reference = FirebaseStorage.instance.ref().child(destination);
    await reference.putFile(pImagesList);
    var res = await reference.getDownloadURL();
    pImagesLink = res;
    // VxToast.show(context, msg: 'Image passed $pImagesLink');
    sendMsg('img');
  }

  getChatId() async {
    isLoading(true);
    await chats
        .where('mess', arrayContains: currentUser!.uid)
        .limit(1)
        .get()
        .then((QuerySnapshot snapshot) {
      if (snapshot.docs.isNotEmpty) {
        chatDocId = snapshot.docs.single.id;
      }
    });
    isLoading(false);
  }

  sendMsg(String msg) async {
    if (msg.trim().isNotEmpty) {
    } else {}
    await chats.doc(chatDocId).update({
      'created_on': FieldValue.serverTimestamp(),
      'last_msg': msg,
      'toId': toId,
      'fromId': fromId,
      'img': pImagesLink,
    });
    chats.doc(chatDocId).collection(messageCollection).doc().set({
      'created_on': FieldValue.serverTimestamp(),
      'msg': msg,
      'img': pImagesLink,
      'uid': fromId
    });
    isLoading(false);
  }
}
