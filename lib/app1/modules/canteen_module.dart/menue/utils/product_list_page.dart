import 'package:cached_network_image/cached_network_image.dart';
import 'package:connect_canteen/app1/cons/colors.dart';
import 'package:connect_canteen/app1/cons/prefs.dart';
import 'package:connect_canteen/app1/cons/style.dart';
import 'package:connect_canteen/app1/model/product_model.dart';
import 'package:connect_canteen/app1/modules/canteen_module.dart/menue/utils/menue_shrimmer.dart';
import 'package:connect_canteen/app1/modules/canteen_module.dart/menue_add/menue_add_controller.dart';
import 'package:connect_canteen/app1/modules/student_modules/filter_product/product_filter_controller.dart';
import 'package:connect_canteen/app1/widget/product_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

class MenueListPage extends StatelessWidget {
  final String title;
  final String image;
  MenueListPage({super.key, required this.image, required this.title});
  final productFilterController = Get.put(ProductFilterController());
  final menueADdController = Get.put(MenueAddController());
  final storage = GetStorage();
  void delete(BuildContext context, String name, String proudctId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 0,
          backgroundColor: AppColors.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(12.0), // Adjust border radius as needed
          ),
          title: Text(
            'Remove  $name',
            style: TextStyle(
              fontSize: 17.5.sp,
              color: Color.fromARGB(221, 37, 36, 36),
              fontWeight: FontWeight.w700,
            ),
          ),
          content: Text(
            'Product Will not able for order.',
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
              onTap: () async {
                Get.back();

                menueADdController.itemDelete(proudctId);
              },
              child: Container(
                padding: EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Remove",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.bold,
                        fontSize: 17.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        // back icons as ios icon
        leading: kIsWeb
            ? null
            : IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Get.back();
                },
              ),
        backgroundColor: AppColors.backgroundColor,
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // container of the 4/10 of the screen width to show the image.
            Container(
              height: 150,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/placeholder.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // text of all proudcts
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text("All Products",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Padding(
              padding: AppPadding.screenHorizontalPadding,
              child: StreamBuilder<List<ProductResponseModel>>(
                stream: productFilterController.getAllMenue(
                    "texasinternationalcollege", title),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return MenueShrimmer();
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text('No data available'),
                    );
                  } else {
                    final menueProducts = snapshot.data!;

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: menueProducts.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onLongPress: () {
                            storage.read(userTypes) != 'canteenHelper'
                                ? delete(context, menueProducts[index].name,
                                    menueProducts[index].productId)
                                : null;
                          },
                          child: ProductCard(
                            userType: storage.read(userTypes) == "canteenHelper"
                                ? 'canteenHelper'
                                : 'canteen',
                            productId: menueProducts[index].productId,
                            active: true,
                            type: menueProducts[index].type,
                            name: menueProducts[index].name,
                            imageUrl: menueProducts[index].proudctImage,
                            price: menueProducts[index].price,
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
