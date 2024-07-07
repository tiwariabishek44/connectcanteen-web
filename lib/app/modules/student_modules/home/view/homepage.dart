//----------this is the home page
import 'package:connect_canteen/app/widget/custom_loging_widget.dart';
import 'package:connect_canteen/app/config/colors.dart';
import 'package:connect_canteen/app/config/style.dart';
import 'package:connect_canteen/app/modules/common/login/login_controller.dart';
import 'package:connect_canteen/app/modules/student_modules/home/product_controller.dart';
import 'package:connect_canteen/app/modules/student_modules/add_order/view/product_gridview.dart';
import 'package:connect_canteen/app/widget/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final homepagecontroller = Get.put(ProductController());
  final loginController = Get.put(LoginController());

  Future<void> _refreshData() async {
    homepagecontroller
        .fetchProducts(); // Fetch data based on the selected category
    loginController.fetchUserData();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LoginController().fetchUserData();
    return Scaffold(
      backgroundColor:
          AppColors.greyColor, // Make scaffold background transparent

      body: RefreshIndicator(
        onRefresh: () => _refreshData(),
        child: Obx(() {
          if (homepagecontroller.isLoading.value) {
            return Container(
              height: 100.h,
              width: 100.h,
              color: Color(0xff06C167),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTopBar(),
                        SizedBox(
                          height: 2.h,
                        ),
                        Padding(
                          padding: AppPadding.screenHorizontalPadding,
                          child: Text(
                            "Popular Food Items",
                            style: AppStyles.appbar,
                          ),
                        ),
                        Padding(
                          padding: AppPadding.screenHorizontalPadding,
                          child: ProductGrid(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
