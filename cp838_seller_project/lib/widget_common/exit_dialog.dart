import 'package:cp838_seller_project/consts/consts.dart';
import 'package:cp838_seller_project/widget_common/custom_button.dart';
import 'package:flutter/services.dart';

Widget exitDialog({required context}) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        10.heightBox,
        "Confirm".text.fontFamily(bold).size(18.0).color(darkFontGrey).make(),
        const Divider(),
        10.heightBox,
        "Are you sure, you want to exit?"
            .text
            .size(16.0)
            .color(darkFontGrey)
            .make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            customButton(
                onPress: () {
                  SystemNavigator.pop();
                },
                color: redColor,
                textColor: whiteColor,
                title: 'Yes'),
            customButton(
                onPress: () {
                  Navigator.pop(context);
                },
                color: blueColor,
                textColor: whiteColor,
                title: 'No')
          ],
        )
            .box
            .color(lightGrey)
            .roundedSM
            .padding(const EdgeInsets.all(12.0))
            .make()
      ],
    ),
  );
}
