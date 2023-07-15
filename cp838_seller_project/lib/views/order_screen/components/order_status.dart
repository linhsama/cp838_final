import 'package:cp838_seller_project/consts/consts.dart';

Widget orderStatus({required icon, required color, required showDone}) {
  return ListTile(
    leading: Icon(icon, color: color)
        .box
        .border(color: color)
        .roundedSM
        .padding(const EdgeInsets.all(4.0))
        .make(),
    trailing: SizedBox(height: 100, width: 250, child: showDone),
  );
}
