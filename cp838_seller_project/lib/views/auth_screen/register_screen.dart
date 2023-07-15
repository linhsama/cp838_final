import 'package:cp838_seller_project/consts/consts.dart';
import 'package:cp838_seller_project/controllers/auth_controller.dart';
import 'package:cp838_seller_project/views/home_screen/home.dart';
import 'package:cp838_seller_project/widget_common/applogo_widget.dart';
import 'package:cp838_seller_project/widget_common/bg_widget.dart';
import 'package:cp838_seller_project/widget_common/custom_button.dart';
import 'package:cp838_seller_project/widget_common/custom_textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isCheck = false;
//controller
  var controller = Get.put(AuthController());
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var shopnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                (context.screenHeight * 0.1).heightBox,
                appLogoWidget(),
                10.heightBox,
                "Join the $appName"
                    .text
                    .fontFamily(bold)
                    .white
                    .size(18.0)
                    .make(),
                15.heightBox,
                Obx(
                  () => Column(
                    children: [
                      customTextField(
                          title: shopname,
                          hint: shopnameHint,
                          controller: shopnameController,
                          obscureText: false,
                          keyboardTypes: TextInputType.text),
                      customTextField(
                          title: email,
                          hint: emailHint,
                          controller: emailController,
                          obscureText: false,
                          keyboardTypes: TextInputType.emailAddress),
                      customTextField(
                          title: password,
                          hint: passwordHint,
                          controller: passwordController,
                          obscureText: true,
                          keyboardTypes: TextInputType.visiblePassword),
                      customTextField(
                          title: confirmPassword,
                          hint: confirmPasswordHint,
                          controller: confirmPasswordController,
                          obscureText: true,
                          keyboardTypes: TextInputType.visiblePassword),
                      5.heightBox,
                      Row(
                        children: [
                          Checkbox(
                            activeColor: purpleColor,
                            checkColor: whiteColor,
                            value: isCheck,
                            onChanged: (value) {
                              setState(() {
                                isCheck = value!;
                              });
                            },
                          ),
                          10.heightBox,
                          Expanded(
                            child: RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: "I agree to the ",
                                    style: TextStyle(
                                      fontFamily: regular,
                                      color: fontGrey,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Terms and Conditions",
                                    style: TextStyle(
                                      fontFamily: regular,
                                      color: purpleColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " & ",
                                    style: TextStyle(
                                      fontFamily: regular,
                                      color: fontGrey,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Privacy Policy",
                                    style: TextStyle(
                                      fontFamily: regular,
                                      color: purpleColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      5.heightBox,
                      controller.isLoading.value
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(purpleColor),
                            )
                          : customButton(
                                  onPress: () async {
                                    if (isCheck != false) {
                                      if (shopnameController.text.isEmpty) {
                                        VxToast.show(context,
                                            msg: 'shopname is required',
                                            textColor: purpleColor);
                                      } else if (emailController.text.isEmpty) {
                                        VxToast.show(context,
                                            msg: 'email is required',
                                            textColor: purpleColor);
                                      } else if (!RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(emailController.text)) {
                                        VxToast.show(context,
                                            msg: 'Email is not valid',
                                            textColor: purpleColor);
                                      } else if (passwordController
                                          .text.isEmpty) {
                                        VxToast.show(context,
                                            msg: 'password is required',
                                            textColor: purpleColor);
                                      } else if (confirmPasswordController
                                          .text.isEmpty) {
                                        VxToast.show(context,
                                            msg: 'confirm password is required',
                                            textColor: purpleColor);
                                      } else if (passwordController.text !=
                                          confirmPasswordController.text) {
                                        VxToast.show(context,
                                            msg: 'password is not the same',
                                            textColor: purpleColor);
                                      } else {
                                        try {
                                          controller.isLoading(true);

                                          await controller
                                              .registerMethod(
                                                  context: context,
                                                  email: emailController.text,
                                                  password:
                                                      passwordController.text)
                                              .then((value) {
                                            if (value != null) {
                                              var addUser =
                                                  controller.storeShopData(
                                                      email:
                                                          emailController.text,
                                                      password:
                                                          passwordController
                                                              .text,
                                                      shopname:
                                                          shopnameController
                                                              .text,
                                                      context: context);
                                              if (addUser != null) {
                                                VxToast.show(context,
                                                    msg: loggedIn);
                                                Future.delayed(
                                                    const Duration(
                                                        milliseconds: 200), () {
                                                  Get.offAll(
                                                      () => const Home());
                                                });
                                              }
                                            }
                                          });
                                        } catch (e) {
                                          auth.signOut();
                                          VxToast.show(context,
                                              msg: e.toString());
                                        }
                                      }
                                      controller.isLoading(false);
                                    } else {
                                      VxToast.show(context,
                                          msg:
                                              'Please accept terms to continue',
                                          textColor: purpleColor);
                                    }
                                  },
                                  color: isCheck ? purpleColor : lightGrey,
                                  textColor:
                                      isCheck ? whiteColor : darkFontGrey,
                                  title: register)
                              .box
                              .width(context.screenWidth - 50)
                              .make(),
                      10.heightBox,
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: alreadyHaveAccount,
                              style:
                                  TextStyle(fontFamily: bold, color: fontGrey),
                            ),
                            TextSpan(
                              text: login,
                              style: TextStyle(
                                  fontFamily: bold, color: purpleColor),
                            ),
                          ],
                        ),
                      ).onTap(() {
                        Get.back();
                      })
                    ],
                  )
                      .box
                      .white
                      .rounded
                      .padding(const EdgeInsets.all(16.0))
                      .width(context.screenWidth - 70)
                      .shadowSm
                      .make(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
