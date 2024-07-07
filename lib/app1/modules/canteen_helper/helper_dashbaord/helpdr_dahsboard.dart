import 'package:connect_canteen/app/config/style.dart';
import 'package:connect_canteen/app1/cons/colors.dart';
import 'package:connect_canteen/app1/modules/canteen_module.dart/dashboard/utils/clickable_action_icon.dart';
import 'package:connect_canteen/app1/modules/canteen_module.dart/dashboard/utils/manager_activity.dart';
import 'package:connect_canteen/app1/modules/canteen_module.dart/dashboard/utils/payment_activity.dart';
import 'package:connect_canteen/app1/modules/canteen_module.dart/dashboard/utils/salse_activity.dart';
import 'package:connect_canteen/app1/modules/canteen_module.dart/menue/menue_page.dart';
import 'package:connect_canteen/app1/modules/canteen_module.dart/report/canteen_report_controller.dart';
import 'package:connect_canteen/app1/modules/canteen_module.dart/report/report_page.dart';
import 'package:connect_canteen/app1/modules/canteen_module.dart/salse_figure/salse_figure.dart';
import 'package:connect_canteen/app1/modules/canteen_module.dart/wallet_class/class_wallet.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HelperDashboard extends StatelessWidget {
  HelperDashboard({super.key});
  final canteenDailyReport = Get.put(CanteenReportController());

  @override
  Widget build(BuildContext context) {
    DateTime nowUtc = DateTime.now().toUtc();
    DateTime nowNepal = nowUtc.add(Duration(hours: 5, minutes: 45));
    final formattedDate = "${nowNepal.day}/${nowNepal.month}/${nowNepal.year}";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        titleSpacing: 4.0.w, // Adjusts the spacing above the title
        title: Text(
          '${formattedDate}',
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 4.0.w),
              child: Text(
                'Dashboard',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.sp),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.screenHorizontalPadding,
          child: Column(
            children: [
              SizedBox(
                height: 2.h,
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.circular(
                      10.0), // Adjust the value for the desired curve
                  boxShadow: [
                    BoxShadow(
                      color:
                          Color.fromARGB(255, 189, 187, 187).withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0,
                          2), // Adjust the values to control the shadow appearance
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
                            canteenDailyReport.selectedDate.value =
                                formattedDate;
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
