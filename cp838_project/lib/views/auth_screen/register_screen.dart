import 'package:cp838_project/consts/consts.dart';
import 'package:cp838_project/controllers/auth_controller.dart';
import 'package:cp838_project/views/home_screen/home.dart';
import 'package:cp838_project/widget_common/applogo_widget.dart';
import 'package:cp838_project/widget_common/bg_widget.dart';
import 'package:cp838_project/widget_common/custom_button.dart';
import 'package:cp838_project/widget_common/custom_textfield.dart';

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
                          title: username,
                          hint: usernameHint,
                          controller: usernameController,
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
                            activeColor: blueColor,
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
                                      color: blueColor,
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
                                      color: blueColor,
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
                              valueColor: AlwaysStoppedAnimation(redColor),
                            )
                          : customButton(
                                  onPress: () async {
                                    if (isCheck != false) {
                                      if (usernameController.text.isEmpty) {
                                        VxToast.show(context,
                                            msg: 'username is required',
                                            textColor: redColor);
                                      } else if (emailController.text.isEmpty) {
                                        VxToast.show(context,
                                            msg: 'email is required',
                                            textColor: redColor);
                                      } else if (!RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(emailController.text)) {
                                        VxToast.show(context,
                                            msg: 'Email is not valid',
                                            textColor: redColor);
                                      } else if (passwordController
                                          .text.isEmpty) {
                                        VxToast.show(context,
                                            msg: 'password is required',
                                            textColor: redColor);
                                      } else if (confirmPasswordController
                                          .text.isEmpty) {
                                        VxToast.show(context,
                                            msg: 'confirm password is required',
                                            textColor: redColor);
                                      } else if (passwordController.text !=
                                          confirmPasswordController.text) {
                                        VxToast.show(context,
                                            msg: 'password is not the same',
                                            textColor: redColor);
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
                                                  controller.storeUserData(
                                                      email:
                                                          emailController.text,
                                                      password:
                                                          passwordController
                                                              .text,
                                                      username:
                                                          usernameController
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
                                          textColor: redColor);
                                    }
                                  },
                                  color: isCheck ? blueColor : lightGrey,
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
                              style:
                                  TextStyle(fontFamily: bold, color: blueColor),
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
