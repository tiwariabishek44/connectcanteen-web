import 'package:connect_canteen/app1/modules/canteen_helper/helper_dashbaord/helpdr_dahsboard.dart';
import 'package:connect_canteen/app1/modules/canteen_helper/verify%20list/verify_order_list.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelperScreenController extends GetxController {
  var currentTab = 0.obs;
  final PageStorageBucket bucket = PageStorageBucket();
  Rx<Widget> currentScreen = Rx<Widget>(HelperDashboard());

  var isloading = false.obs;
}
