import 'package:cp838_project/consts/consts.dart';
import 'package:cp838_project/controllers/cart_controller.dart';
import 'package:cp838_project/views/cart_screen/payment_screen.dart';
import 'package:cp838_project/widget_common/custom_button.dart';
import 'package:cp838_project/widget_common/custom_textfield.dart';

class ShippingScreen extends StatelessWidget {
  const ShippingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Checkout".text.fontFamily(bold).color(darkFontGrey).make(),
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        height: 60,
        child: customButton(
            onPress: () {
              if (controller.addressController.text.length > 10) {
                Get.to(() => const PaymentScreen());
              } else {
                VxToast.show(context, msg: 'please fill the form');
              }
            },
            color: blueColor,
            textColor: whiteColor,
            title: 'Continune'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(12.0),
          child: Column(children: [
            customTextField(
                title: 'Fullname',
                hint: 'Fullname',
                controller: controller.fullnameController,
                obscureText: false,
                keyboardTypes: TextInputType.text),
            customTextField(
                title: 'Address',
                hint: 'Address',
                controller: controller.addressController,
                obscureText: false,
                keyboardTypes: TextInputType.text),

            // customTextField(
            //     title: 'State',
            //     hint: 'State',
            //     controller: controller.stateController,
            //     obscureText: false,
            //     keyboardTypes: TextInputType.text),
            // customTextField(
            //     title: 'Postal Code',
            //     hint: 'Postal Code',
            //     controller: controller.postalCodeController,
            //     obscureText: false,
            //     keyboardTypes: TextInputType.number),
            customTextField(
                title: 'Phone Number',
                hint: 'Phone Number',
                controller: controller.phoneNumberController,
                obscureText: false,
                keyboardTypes: TextInputType.number),
          ]),
        ),
      ),
    );
  }
}
