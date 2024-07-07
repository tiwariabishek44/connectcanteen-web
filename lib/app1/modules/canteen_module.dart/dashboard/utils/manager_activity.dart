import 'package:connect_canteen/app1/cons/colors.dart';
import 'package:connect_canteen/app1/cons/style.dart';
import 'package:connect_canteen/app1/modules/canteen_module.dart/dashboard/utils/clickable_action_icon.dart';
import 'package:connect_canteen/app1/modules/canteen_module.dart/menue/menue_page.dart';
import 'package:connect_canteen/app1/modules/canteen_module.dart/report/canteen_report_controller.dart';
import 'package:connect_canteen/app1/modules/canteen_module.dart/report/report_page.dart';
import 'package:connect_canteen/app1/modules/canteen_module.dart/wallet_class/class_wallet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ManagerActivity extends StatelessWidget {
  final canteenDailyReport = Get.put(CanteenReportController());

  ManagerActivity({Key? key, required this.date}) : super(key: key);
  final String date;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(
            10.0), // Adjust the value for the desired curve
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 189, 187, 187).withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(
                0, 2), // Adjust the values to control the shadow appearance
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(children: [
          Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Manager Activity",
                style: AppStyles.topicsHeading,
              )),
          SizedBox(
            height: 1.h,
          ),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            childAspectRatio: 1.33,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            physics: NeverScrollableScrollPhysics(),
            children: [
              buildClickableIcon(
                icon: Icons.restaurant_menu,
                label: 'Menue List',
                onTap: () {
                  Get.to(() => CanteenMenuePage(),
                      transition: Transition.cupertinoDialog);
                },
              ),
              buildClickableIcon(
                icon: Icons.analytics,
                label: 'Daily Report',
                onTap: () {
                  canteenDailyReport.selectedDate.value = date;
                  Get.to(
                      () => CanteenDailyReport(
                            isDailyReport: true,
                          ),
                      transition: Transition.cupertinoDialog);
                  // // Handle click for Analytics\
                },
              ),
              buildClickableIcon(
                icon: Icons.analytics,
                label: 'Order List',
                onTap: () {
                  Get.to(
                      () => ClassWalletPage(
                            isrecord: 'orderlist',
                          ),
                      transition: Transition.cupertinoDialog);

                  // // Handle click for Analytics\
                },
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
