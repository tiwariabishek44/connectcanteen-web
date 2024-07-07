import 'package:connect_canteen/app/config/colors.dart';
import 'package:connect_canteen/app/modules/canteen_helper/profile/profile.dart';
import 'package:connect_canteen/app/modules/canteen_helper/verified%20orders/get_verified_orders.dart';
import 'package:connect_canteen/app/modules/canteen_helper/helper%20main%20screen/main_screen_controller.dart';
import 'package:connect_canteen/app/modules/canteen_helper/verified%20orders/verify_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HelperMainScreen extends StatelessWidget {
  HelperMainScreen({Key? key});

  final userController = Get.put(MainScreenController());
  final verifyController = Get.put(VerifyController());

  final List<Widget> pages = [
    CanteenHelper(),
    HelperProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          verifyController.closeStream();
          return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                elevation: 0,
                backgroundColor: AppColors.backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      12.0), // Adjust border radius as needed
                ),
                title: Text(
                  'Exit App?',
                  style: TextStyle(
                    fontSize: 17.5.sp,
                    color: Color.fromARGB(221, 37, 36, 36),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                content: Text(
                  'Are you sure you want to exit the app?',
                  style: TextStyle(
                    color: const Color.fromARGB(221, 72, 71, 71),
                    fontSize: 16.0.sp,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      // Close the dialog

                      Get.back();
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          color: Colors.purple),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      verifyController.closeStream();
                      Navigator.of(context).pop(true);
                    },
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        "Exit",
                        style: TextStyle(
                          color: Color.fromARGB(255, 225, 6, 6),
                          fontWeight: FontWeight.bold,
                          fontSize: 17.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
          // Allow back navigation
        },
        child: Obx(
          () => PageStorage(
            bucket: userController.bucket,
            child: userController.currentScreen.value,
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: Color.fromARGB(
                    255, 210, 207, 207), // Specify your desired border color
                width: 0.50, // Specify the border width
              ),
            ),
          ),
          height: 7.5.h,
          child: MyBottomNavigationBar(
            currentIndex: userController.currentTab.value,
            onTap: (index) {
              userController.currentTab.value = index;
              userController.currentScreen.value = pages[index];
            },
            items: [
              MyBottomNavigationBarItem(
                  nonSelectedicon: Icons.home_outlined,
                  icon: Icons.home,
                  label: 'Home'),
              MyBottomNavigationBarItem(
                  nonSelectedicon: Icons.settings_outlined,
                  icon: Icons.settings,
                  label: 'Settings'),
            ],
          ),
        ),
      ),
    );
  }
}

class MyBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<MyBottomNavigationBarItem> items;

  MyBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: items.map((item) {
        var index = items.indexOf(item);
        return Expanded(
          child: InkWell(
            onTap: () => onTap(index),
            splashColor: Colors.transparent, // Disable tap effect

            child: item.build(index == currentIndex),
          ),
        );
      }).toList(),
    );
  }
}

class MyBottomNavigationBarItem {
  final IconData icon;
  final IconData nonSelectedicon;

  final String label;

  MyBottomNavigationBarItem({
    required this.nonSelectedicon,
    required this.icon,
    required this.label,
  });

  Widget build(bool isSelected) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSelected ? icon : nonSelectedicon,
            color: isSelected
                ? Colors.black
                : const Color.fromARGB(255, 69, 67, 67),
            // Outline the icon if not selected
            size: 20.0.sp,
            semanticLabel: label,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: isSelected
                  ? Colors.black
                  : const Color.fromARGB(255, 69, 67, 67),
            ),
          ),
        ],
      ),
    );
  }
}