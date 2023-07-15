import 'package:cp838_project/consts/consts.dart';
import 'package:cp838_project/controllers/home_controller.dart';
import 'package:cp838_project/controllers/profile_controller.dart';
import 'package:cp838_project/views/cart_screen/cart_screen.dart';
import 'package:cp838_project/views/category_screen/category_screen.dart';
import 'package:cp838_project/views/home_screen/home_screen.dart';
import 'package:cp838_project/views/profile_screen/profile_screen.dart';
import 'package:cp838_project/widget_common/exit_dialog.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var controller = Get.put(HomeController());

  var navbarItems = [
    BottomNavigationBarItem(
        icon: Image.asset(
          icHome,
          width: 26.0,
        ),
        label: home),
    BottomNavigationBarItem(
        icon: Image.asset(
          icCategories,
          width: 26.0,
        ),
        label: categories),
    BottomNavigationBarItem(
        icon: Image.asset(
          icCart,
          width: 26.0,
        ),
        label: cart),
    BottomNavigationBarItem(
        icon: Image.asset(
          icProfile,
          width: 26.0,
        ),
        label: profile),
  ];

  var navBody = [
    const HomeScreen(),
    const CategoryScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => exitDialog(context: context),
        );
        return false;
      },
      child: Scaffold(
        // appBar: AppBar(
        //   title: TextButton(
        //     onPressed: () {
        //       controller.addProductRandom();
        //     },
        //     child: const Text('add'),
        //   ),
        // ),
        body: Column(
          children: [
            Obx(
              () => Expanded(
                child: navBody.elementAt(controller.currentNavIndex.value),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            items: navbarItems,
            backgroundColor: whiteColor,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: blueColor,
            selectedLabelStyle: const TextStyle(fontFamily: semibold),
            onTap: (value) {
              controller.currentNavIndex.value = value;
            },
          ),
        ),
      ),
    );
  }
}
