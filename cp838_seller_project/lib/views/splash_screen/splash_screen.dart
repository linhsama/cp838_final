import 'package:cp838_seller_project/consts/consts.dart';
import 'package:cp838_seller_project/controllers/home_controller.dart';
import 'package:cp838_seller_project/controllers/product_controller.dart';
import 'package:cp838_seller_project/services/firestore_services.dart';
import 'package:cp838_seller_project/views/auth_screen/login_screen.dart';
import 'package:cp838_seller_project/views/home_screen/home.dart';
import 'package:cp838_seller_project/widget_common/applogo_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // START creating a method to change screen
  changeScreen() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        // Use getX
        auth.authStateChanges().listen((User? user) {
          if (user == null && mounted) {
            Get.to(() => const LoginScreen());
          } else {
            var controller = Get.put(HomeController());

            @override
            void initState() async {
              super.initState();
              await controller.getCountOrder();
              await controller.getCountProduct();
              await controller.getTotalSale();
              controller.orderCount;
              controller.productCount;
            }

            Get.to(() => const Home());
          }
        });
      },
    );
  }

  // END creating a method to change screen
  // START initState
  @override
  void initState() {
    super.initState();
    FirestoreServices();
    changeScreen();
  }
  // END initState

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purpleColor,
      body: Center(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                icSplashBg,
                width: 300.0,
              ),
            ),
            20.heightBox,
            appLogoWidget(),
            appName.text.fontFamily(bold).size(22.0).white.make(),
            5.heightBox,
            appVersion.text.white.make(),
            const Spacer(),
            madeBy.text.white.fontFamily(semibold).make(),
            30.heightBox,
          ],
        ),
      ),
    );
  }
}
