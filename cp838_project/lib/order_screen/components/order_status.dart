import 'package:cp838_project/consts/consts.dart';

Widget orderStatus(
    {required icon, required color, required title, required showDone}) {
  return ListTile(
    leading: Icon(icon, color: color)
        .box
        .border(color: color)
        .roundedSM
        .padding(const EdgeInsets.all(4.0))
        .make(),
    trailing: SizedBox(
      height: 100,
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          "$title"
              .toString()
              .text
              .color(darkFontGrey)
              .fontFamily(semibold)
              .make(),
          showDone ? const Icon(Icons.done, color: redColor) : Container(),
        ],
      ),
    ),
  );
}
