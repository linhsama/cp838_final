import 'package:cp838_seller_project/views/chat_screen/messages_screen.dart';
import 'package:cp838_seller_project/consts/consts.dart';
import 'package:cp838_seller_project/controllers/auth_controller.dart';
import 'package:cp838_seller_project/controllers/profile_controller.dart';
import 'package:cp838_seller_project/services/firestore_services.dart';
import 'package:cp838_seller_project/views/auth_screen/login_screen.dart';
import 'package:cp838_seller_project/views/profile_screen/components/details_cart.dart';
import 'package:cp838_seller_project/views/profile_screen/edit_profile_screen.dart';
import 'package:cp838_seller_project/views/profile_screen/edit_shop_screen.dart';
import 'package:cp838_seller_project/widget_common/bg_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //
  var controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: profile.text.color(whiteColor).fontFamily(semibold).make(),
        ),
        body: StreamBuilder(
            stream: FirestoreServices.getShop(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  ),
                );
              } else {
                var data = snapshot.data!.docs[0];

                return Column(
                  children: [
                    // profile detail
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.network(
                            data['imageUrl'],
                            width: 100,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make(),
                          10.widthBox,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "${data['shopname']}"
                                    .text
                                    .fontFamily(semibold)
                                    .white
                                    .make(),
                                5.heightBox,
                                "${data['email']}".text.white.make(),
                              ],
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () {
                              controller.shopnameController.text =
                                  data['shopname'];
                              controller.passwordController.text =
                                  data['password'];
                              Get.to(() => EditProfileScreen(data: data));
                            },
                            style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: whiteColor)),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.edit,
                                  color: whiteColor,
                                ),
                                editProfile.text
                                    .fontFamily(semibold)
                                    .white
                                    .make(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    //
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     detailsCard(
                    //         width: context.screenWidth / 2.5,
                    //         count: controller.countOrder,
                    //         title: "your orders"),
                    //     detailsCard(
                    //         width: context.screenWidth / 2.5,
                    //         count: controller.countMessage,
                    //         title: "your messages"),
                    //   ],
                    // ),
                    //Button Section
                    20.heightBox,
                    ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return const Divider(color: lightGrey);
                      },
                      itemCount: profileButtonIconList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            switch (index) {
                              case 0:
                                controller.shopnameController.text =
                                    data['shopname'];
                                controller.passwordController.text =
                                    data['password'];
                                Get.to(() => EditShopScreen(data: data));
                                break;
                              case 1:
                                Get.to(() => const Messagescreen());
                                break;
                            }
                          },
                          leading: Image.asset(
                            profileButtonIconList[index],
                            width: 22,
                          ),
                          title: profileButtonList[index]
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                        );
                      },
                    )
                        .box
                        .white
                        .roundedSM
                        .padding(const EdgeInsets.symmetric(horizontal: 16.0))
                        .shadowSm
                        .margin(const EdgeInsets.all(12.0))
                        .make()
                        .box
                        .make(),

                    // edit profile
                    20.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OutlinedButton(
                          onPressed: () => showDialog<String>(
                            barrierDismissible: false, // user must tap button!
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Confirm'),
                              content: const Text('Do you want to sign out?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  child: const Text(
                                    'OK',
                                    style: TextStyle(color: redColor),
                                  ),
                                  onPressed: () async {
                                    Navigator.pop(context, 'OK');
                                    await Get.put(AuthController()
                                        .signOutMethod(context: context));
                                    Get.offAll(() => const LoginScreen());
                                  },
                                ),
                              ],
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                              backgroundColor: red,
                              side: const BorderSide(color: red)),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.logout,
                                color: whiteColor,
                              ),
                              logout.text
                                  .fontFamily(semibold)
                                  .color(whiteColor)
                                  .make(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
            }),
      ),
    );
  }
}
