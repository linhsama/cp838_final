import 'package:cp838_seller_project/consts/consts.dart';
import 'package:cp838_seller_project/controllers/auth_controller.dart';
import 'package:cp838_seller_project/views/auth_screen/register_screen.dart';
import 'package:cp838_seller_project/views/home_screen/home.dart';
import 'package:cp838_seller_project/widget_common/applogo_widget.dart';
import 'package:cp838_seller_project/widget_common/bg_widget.dart';
import 'package:cp838_seller_project/widget_common/custom_button.dart';
import 'package:cp838_seller_project/widget_common/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //controller
  var controller = Get.put(AuthController());
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

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
                "Login to $appName"
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
                        obscureText: false,
                        title: email,
                        hint: emailHint,
                        controller: emailController,
                        keyboardTypes: TextInputType.emailAddress,
                      ),
                      customTextField(
                          obscureText: true,
                          title: password,
                          hint: passwordHint,
                          controller: passwordController,
                          keyboardTypes: TextInputType.visiblePassword),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: forgetPassword.text.color(purpleColor).make(),
                        ),
                      ),
                      5.heightBox,
                      controller.isLoading.value
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(purpleColor),
                            )
                          : customButton(
                                  onPress: () async {
                                    if (emailController.text.isEmpty) {
                                      VxToast.show(context,
                                          msg: 'email is required',
                                          textColor: purpleColor);
                                    } else if (passwordController
                                        .text.isEmpty) {
                                      VxToast.show(context,
                                          msg: 'password is required',
                                          textColor: purpleColor);
                                    } else if (!RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(emailController.text)) {
                                      VxToast.show(context,
                                          msg: 'Email is not valid',
                                          textColor: purpleColor);
                                    } else {
                                      controller.isLoading(true);
                                      try {
                                        await controller
                                            .loginMethod(
                                                context: context,
                                                email: emailController.text,
                                                password:
                                                    passwordController.text)
                                            .then((value) {
                                          if (value != null) {
                                            VxToast.show(context,
                                                msg: loggedIn);
                                            Future.delayed(
                                                const Duration(
                                                    milliseconds: 200), () {
                                              Get.offAll(() => const Home());
                                            });
                                          }
                                        });
                                      } catch (e) {
                                        auth.signOut();
                                        VxToast.show(context,
                                            msg: e.toString());
                                      }
                                      controller.isLoading(false);
                                    }
                                  },
                                  color: purpleColor,
                                  textColor: whiteColor,
                                  title: login)
                              .box
                              .width(context.screenWidth - 50)
                              .make(),
                      5.heightBox,
                      createNewAccount.text.color(fontGrey).make(),
                      5.heightBox,
                      customButton(
                              onPress: () {
                                Get.to(() => const RegisterScreen());
                              },
                              color: blueColor,
                              textColor: whiteColor,
                              title: register)
                          .box
                          .width(context.screenWidth - 50)
                          .make(),
                      10.heightBox,
                      loginWith.text.color(fontGrey).make(),
                      5.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          2,
                          (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: lightGrey,
                              radius: 25.0,
                              child: Image.asset(
                                socialIconList[index],
                                width: 30.0,
                              ),
                            ),
                          ),
                        ),
                      )
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
