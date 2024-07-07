import 'package:connect_canteen/app/config/colors.dart';
import 'package:connect_canteen/app/config/style.dart';
import 'package:connect_canteen/app1/modules/canteen_module.dart/mealTime/meal_time.dart';
import 'package:connect_canteen/app1/modules/common/login/login_controller.dart';
import 'package:connect_canteen/app1/modules/student_modules/acount_info/acount_info.dart';
import 'package:connect_canteen/app1/modules/common/wallet/wallet_page.dart';
import 'package:connect_canteen/app1/widget/logout_cornfiration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProfilePage extends StatelessWidget {
  final loignController = Get.put(LoginController());

  Widget buildCustomListTile({
    required String title,
    required String subtitle,
    required IconData trailing,
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 19.sp, color: Colors.black),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            color: Colors.grey[700]),
      ),
      trailing: Icon(
        trailing,
        color: Colors.grey[700],
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        titleSpacing: 4.0.w, // Adjusts the spacing above the title
        title: Text(
          "Settings",
          style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w400),
        ),

        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 4.0.w),
              child: Text(
                'System Settings',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.sp),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: AppPadding.screenHorizontalPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 2.h,
              ),
              buildCustomListTile(
                  onTap: () {
                    Get.to(() => AccountInfo(),
                        transition: Transition.cupertinoDialog);
                  },
                  title: 'My Account ',
                  subtitle: 'Your Accout Details',
                  trailing: Icons.chevron_right),
              SizedBox(
                height: 1.h,
              ),
              buildCustomListTile(
                  onTap: () {
                    Get.to(
                        () => WalletPage(
                              grade: loignController
                                  .studentDataResponse.value!.classes,
                              userId: loignController
                                  .studentDataResponse.value!.userid,
                              isStudent: true,
                              name: loignController
                                  .studentDataResponse.value!.name,
                              image: loignController
                                  .studentDataResponse.value!.profilePicture,
                            ),
                        transition: Transition.cupertinoDialog,
                        duration: duration);
                  },
                  title: 'Wallet ',
                  subtitle: 'Your Wallet Your money',
                  trailing: Icons.chevron_right),

              // buildCustomListTile(
              //     onTap: () {
              //       Get.to(
              //           () => CoinCollectPage(
              //                 userId: loignController
              //                     .studentDataResponse.value!.userid,
              //               ),
              //           transition: Transition.cupertinoDialog);
              //     },
              //     //
              //     title: 'Coins  ',
              //     subtitle: 'Get your gifts and rewards ',
              //     trailing: Icons.chevron_right),
              // buildCustomListTile(
              //     onTap: () {
              //       Get.to(
              //           () => OrderCheckoutPage(
              //                 cid: loignController
              //                     .studentDataResponse.value!.groupcod,
              //               ),
              //           transition: Transition.cupertinoDialog);
              //     },
              //     //
              //     title: 'Checkout',
              //     subtitle: 'Checkout your meal',
              //     trailing: Icons.chevron_right),
              buildCustomListTile(
                  onTap: () {
                    Get.to(() => Mealtime(),
                        transition: Transition.cupertinoDialog);
                  },
                  //
                  title: 'Meal Time   ',
                  subtitle: 'Get you meal time information ',
                  trailing: Icons.chevron_right),
              buildCustomListTile(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return LogoutConfirmationDialog(
                          isbutton: true,
                          heading: 'Alert',
                          subheading:
                              "Do you want to logout of the application?",
                          firstbutton: "Yes",
                          secondbutton: 'No',
                          onConfirm: () {
                            loignController.logout();
                          },
                        );
                      },
                    );
                  },
                  title: 'LogOut',
                  subtitle: 'Get out from system',
                  trailing: Icons.chevron_right)
            ],
          ),
        ),
      ),
    );
  }
}
