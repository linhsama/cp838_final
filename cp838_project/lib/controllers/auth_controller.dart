import 'package:cp838_project/consts/consts.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  // login method
  Future<UserCredential?> loginMethod(
      {required email, required password, required context}) async {
    UserCredential? userCredential;
    String msg = '';
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        msg = 'No user found for that email.';
        printError(info: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        msg = 'Wrong password provided for that user.';
        printError(info: 'Wrong password provided for that user.');
      }
    }
    if (userCredential == null) {
      VxToast.show(context, msg: msg.toString(), textColor: redColor);
      return null;
    }
    return userCredential;
  }

  // register method
  Future<UserCredential?> registerMethod(
      {required email, required password, required context}) async {
    UserCredential? userCredential;
    String msg = '';
    try {
      userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        msg = 'The password provided is too weak';
        printError(info: 'The password provided is too weak.');
        return null;
      } else if (e.code == 'email-already-in-use') {
        msg = 'The account already exists for that email';
        printError(info: 'The account already exists for that email.');
      }
    } catch (e) {
      // msg = e.toString();
      printError(info: '$e');
    }
    if (userCredential == null) {
      VxToast.show(context, msg: msg.toString(), textColor: redColor);
      return null;
    }
    return userCredential;
  }

  // storing data method
  storeUserData(
      {required email,
      required password,
      required username,
      required context}) async {
    try {
      var uid = currentUser?.uid;
      DocumentReference documentReference =
          firestore.collection(userCollection).doc(uid);
      documentReference.set({
        'id': uid,
        'username': username,
        'password': password,
        'email': email,
        'imageUrl':
            'https://firebasestorage.googleapis.com/v0/b/cp838-project.appspot.com/o/images%2Fusers%2Fcat.png?alt=media&token=3f29a138-4963-44cf-bab8-a697c591a5d5'
      });
    } catch (e) {
      VxToast.show(context, msg: e.toString());
      printError(info: '$e');
      return null;
    }

    return currentUser?.uid;
  }

  //sign out method
  signOutMethod({required context}) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  // storing data method
  storeShopData(
      {required email,
      required password,
      required username,
      required context}) async {
    try {
      var uid = currentUser?.uid;
      DocumentReference documentReference =
          firestore.collection(shopCollection).doc(uid);

      documentReference.set({
        'id': uid,
        'username': username,
        'password': password,
        'email': email,
        'address': 'Cần Thơ',
        'rating_count': '0',
        'vote_count': '0',
        'imageUrl':
            'https://firebasestorage.googleapis.com/v0/b/cp838-project.appspot.com/o/images%2Fusers%2Fcat.png?alt=media&token=3f29a138-4963-44cf-bab8-a697c591a5d5'
      });
    } catch (e) {
      VxToast.show(context, msg: e.toString());
      printError(info: '$e');
      return null;
    }

    return currentUser?.uid;
  }
}
