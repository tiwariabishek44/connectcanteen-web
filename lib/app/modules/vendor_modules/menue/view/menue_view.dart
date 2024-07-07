import 'package:connect_canteen/app/config/colors.dart';
import 'package:connect_canteen/app/config/style.dart';
import 'package:connect_canteen/app/modules/common/login/login_controller.dart';
import 'package:connect_canteen/app/modules/student_modules/home/product_controller.dart';
import 'package:connect_canteen/app/modules/student_modules/home/product_upload.dart';
import 'package:connect_canteen/app/modules/vendor_modules/widget/product_grid_view.dart';
import 'package:connect_canteen/app/widget/custom_app_bar.dart';
import 'package:connect_canteen/app/widget/custom_loging_widget.dart';
import 'package:connect_canteen/app/widget/loading_screen.dart';
import 'package:connect_canteen/app/widget/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Menue extends StatelessWidget {
  final homepagecontroller = Get.put(ProductController());

  final logincontroller = Get.put(LoginController());

  Future<void> _refreshData() async {
    homepagecontroller
        .fetchProducts(); // Fetch data based on the selected category
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyColor,
      appBar: CustomAppBar(title: "Canteen Menue"),
      // floatingActionButton: FloatingActionButton(
      //     child: Icon(Icons.add),
      //     onPressed: () {
      //       Get.to(() => ProductUploadPage());
      //     }),
      body: RefreshIndicator(
        onRefresh: () => _refreshData(),
        child: Stack(
          children: [
            Padding(
              padding: AppPadding.screenHorizontalPadding,
              child: Center(
                child: Obx(() {
                  if (homepagecontroller.isLoading.value) {
                    return LoadingWidget();
                  } else {
                    return homepagecontroller.allProductResponse.value == null
                        ? NoDataWidget(
                            message: "There is no items",
                            iconData: Icons.error_outline)
                        : SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.h),
                                  child: VendorProductGrid(),
                                ),
                              ],
                            ),
                          );
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
