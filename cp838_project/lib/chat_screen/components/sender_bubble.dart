import 'package:cp838_project/consts/consts.dart';
import 'package:intl/intl.dart' as intl;

Widget senderBubble({required DocumentSnapshot data}) {
  var t =
      data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();
  var time = intl.DateFormat('h:mma').format(t);

  return Directionality(
    textDirection:
        data['uid'] == currentUser!.uid ? TextDirection.rtl : TextDirection.ltr,
    child: Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: data['uid'] == currentUser!.uid ? blueColor : redColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          data['img'] == null
              ? "${data['msg']}".text.white.size(16).make()
              : Image.network(data['img']),
          10.heightBox,
          time.text.color(whiteColor.withOpacity(0.6)).make()
        ],
      ),
    ),
  );
}
