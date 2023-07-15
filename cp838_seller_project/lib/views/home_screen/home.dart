import 'package:cp838_seller_project/consts/consts.dart';
import 'package:cp838_seller_project/controllers/home_controller.dart';
import 'package:cp838_seller_project/views/order_screen/order_screen.dart';
import 'package:cp838_seller_project/views/category_screen/category_screen.dart';
import 'package:cp838_seller_project/views/home_screen/home_screen.dart';
import 'package:cp838_seller_project/views/profile_screen/profile_screen.dart';
import 'package:cp838_seller_project/widget_common/exit_dialog.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    controller.getCountOrder();
    controller.getCountProduct();
    controller.getTotalSale();
    controller.orderCount;
    controller.productCount;
  }

  var navbarItems = [
    BottomNavigationBarItem(
        icon: Image.asset(
          icDashboard,
          width: 26.0,
          color: darkGrey,
        ),
        label: dashboard),
    BottomNavigationBarItem(
        icon: Image.asset(
          icProduct,
          width: 26.0,
          color: darkGrey,
        ),
        label: product),
    BottomNavigationBarItem(
        icon: Image.asset(
          icOrder,
          width: 26.0,
          color: darkGrey,
        ),
        label: order),
    BottomNavigationBarItem(
        icon: Image.asset(
          icSetting,
          width: 26.0,
          color: darkGrey,
        ),
        label: setting),
  ];

  var navBody = [
    const HomeScreen(),
    const CategoryScreen(),
    const OrderScreen(),
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
            selectedItemColor: purpleColor,
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
